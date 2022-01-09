#include <iostream>
#include <boost/property_tree/json_parser.hpp>
#include <boost/property_tree/ptree.hpp>

using namespace std;

const std::string CONFIG_PATH = "./config.json";

// temporary values, will be set by readConfig()
uint32_t MAX_KERNELS = -1;
uint16_t OUTGOING_PORT_ADDR = -1;
std::string WEB_ROOT_DIR = "/dev/null";

void readConfig(std::string configPath) {

    boost::property_tree::ptree loadedPTreeRoot;
    boost::property_tree::read_json(CONFIG_PATH, loadedPTreeRoot);

    MAX_KERNELS = loadedPTreeRoot.get_child("threads").get_value<uint32_t>();
    OUTGOING_PORT_ADDR = loadedPTreeRoot.get_child("port").get_value<uint16_t>();
    WEB_ROOT_DIR = loadedPTreeRoot.get_child("web_root").get_value<std::string>();
}

int main() {

    std::cout << "[main.cu] READING CONFIGURATION FILE" << endl;

    // read the config file
    readConfig(CONFIG_PATH);

    std::cout << "[main.cu] STARTING SERVER ON PORT " << std::to_string(OUTGOING_PORT_ADDR) << " WITH " << std::to_string(MAX_KERNELS) << " THREADS." << endl;

    // spawn the kernels

    std::cout << "[main.cu] SPAWNING " << std::to_string(MAX_KERNELS) << " KERNELS FOR WEB ROOT " << WEB_ROOT_DIR << endl;

    return 0;
}