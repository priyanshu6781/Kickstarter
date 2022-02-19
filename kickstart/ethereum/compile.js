const path = require('path');
const solc = require('solc');
const fs = require('fs-extra');

const buildPath = path.resolve(__dirname, 'build');
fs.removeSync(buildPath);  // logic to delete build folder if exist

const campaignPath = path.resolve(__dirname, 'contracts', 'campaign.sol');
const source = fs.readFileSync(campaignPath, 'utf8');  // read the content of our contract
const output = solc.compile(source, 1).contracts;

fs.ensureDirSync(buildPath);  // checks if dir exists

// console.log(output);
for (let contract in output) {
    fs.outputJSONSync(
        path.resolve(buildPath, contract.replace(':', '') + '.json'), 
        output[contract]
    );
}