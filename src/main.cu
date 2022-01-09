#include <cuda_device_runtime_api.h>
#include <iostream>
#include <boost/property_tree/json_parser.hpp>
#include <boost/property_tree/ptree.hpp>

#define BLOCK_SIZE 256

using namespace std;

const std::string CONFIG_PATH = "./config.json";

// temporary values, will be set by readConfig()
uint32_t MAX_KERNELS = 0;
uint16_t OUTGOING_PORT_ADDR = 0;
std::string WEB_ROOT_DIR = "/dev/null";

__host__
void readConfig(std::string configPath) {

    boost::property_tree::ptree loadedPTreeRoot;
    boost::property_tree::read_json(CONFIG_PATH, loadedPTreeRoot);

    MAX_KERNELS = loadedPTreeRoot.get_child("threads").get_value<uint32_t>();
    OUTGOING_PORT_ADDR = loadedPTreeRoot.get_child("port").get_value<uint16_t>();
    WEB_ROOT_DIR = loadedPTreeRoot.get_child("web_root").get_value<std::string>();
}

__global__
void webKernel() {

    const uint32_t THREAD_ID = (blockIdx.x * blockDim.x) + threadIdx.x;
}

__host__
int main() {

    // read the config file
    std::cout << "[main.cu] READING CONFIGURATION FILE" << endl;
    readConfig(CONFIG_PATH);

    // spawn the kernels
    std::cout << "[main.cu] STARTING SERVER ON PORT " << std::to_string(OUTGOING_PORT_ADDR) << " WITH " << std::to_string(MAX_KERNELS) << " THREADS USING THE WEB ROOT DIR " << WEB_ROOT_DIR << endl;
    webKernel<<<BLOCK_SIZE * ((MAX_KERNELS / BLOCK_SIZE) + 1), BLOCK_SIZE>>>();

    // handle a graceful exit
    cudaDeviceSynchronize();
    std::cout << "[main.cu] EXITED GRACEFULLY";

    return 0;
}