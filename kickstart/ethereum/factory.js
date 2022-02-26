import web3 from './web3';
import CampaignFactory from './build/CampaignFactory.json';

const instance = new web3.eth.Contract(
    JSON.parse(CampaignFactory.interface),
    '0xaB7Df8E01D8bb24c4C41e3c35E3571Ac4F6Aa043'
);

export default instance;