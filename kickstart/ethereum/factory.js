import web3 from './web3';
import CampaignFactory from './build/CampaignFactory.json';

const instance = new web3.eth.Contract(
    JSON.parse(CampaignFactory.interface),
    '0x5F5E4F4a9252ec16bb565FA6708B19893AA50C40'
);

export default instance;