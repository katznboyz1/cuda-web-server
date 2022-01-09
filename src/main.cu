#include <iostream>
#include <boost/property_tree/json_parser.hpp>

using namespace std;

const std::string CONFIG_PATH = "./config.json";

// temporary values, will be set by readConfig()
uint32_t MAX_KERNELS = -1;
uint16_t OUTGOING_PORT_ADDR = -1;
std::string WEB_ROOT_DIR = "/dev/null";

void readConfig(std::string configPath) {


}

int main() {

    std::cout << "[main.cu] READING CONFIGURATION FILE" << endl;

    // read the config file
    readConfig(CONFIG_PATH);

    std::cout << "[main.cu] STARTING SERVER ON PORT " << std::to_string(OUTGOING_PORT_ADDR) << " WITH " << std::to_string(MAX_KERNELS) << "THREADS." << endl;

    // spawn the kernels

    std::cout << "[main.cu] SPAWNING " << std::to_string(MAX_KERNELS) << " KERNELS FOR WEB ROOT " << WEB_ROOT_DIR << endl;

    return 0;
}