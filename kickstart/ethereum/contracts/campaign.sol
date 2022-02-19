pragma solidity ^0.4.17;

contract CampaignFactory {
    address[] public deployedCampaigns;

    function createCampaign(uint minimum) public {  // we are using argument of the constructor
        address newCampaign = new Campaign(minimum, msg.sender);
        deployedCampaigns.push(newCampaign);
    }

    function getDeployedCampaigns() public view returns (address[]) {
        return deployedCampaigns;
    }
}

contract Campaign {
    struct Request {
        string description;  // unlike js we use ';' after every variable declared
        uint value;
        address recipient;
        bool complete;
        uint approvalCount;
        mapping(address => bool) approvals;
    }
    
    Request[] public requests;  // it acts as an array of Request 
    address public manager;
    uint public minimumContribution;
    mapping(address => bool) public approvers;
    uint public approversCount;
    // address[] public approvers;

    modifier restricted() {
        require(msg.sender == manager);
        _; // it virtually takes a function and paste it here
    }

    constructor(uint minimum, address creator) public {
        manager = creator;
        minimumContribution = minimum;
    }

    function contribute() public payable {
        require(msg.value > minimumContribution);
        
        // reinitializing value of approvers to be true
        approvers[msg.sender] = true;  
        // updating approversCount
        approversCount++;
    }

    function createRequest(string description, uint value, address recipient) 
    public restricted {
        // initializing struct
        Request memory newRequest = Request({
            // Request = new variable that contain a 'Request'
            // newRequest = variable's name is 'newRequest'
            // Request({}) = create a new instance of Request
            description: description,
            value: value,
            recipient: recipient,
            complete: false,
            approvalCount: 0
            // we don't need to initialize approvals since it is a mapping
        });

        // alternate syntax to above expression
        /* Request(description, value, recipient, false); */
        // avoid using this syntax

        requests.push(newRequest);
    }

    function approveRequest(uint index) public {
        Request storage request = requests[index];
        
        // make sure person calling this function has donated
        require(approvers[msg.sender]);  // this will check for boolean in mapping
        // make sure person calling this function hasn't voted
        require(!request.approvals[msg.sender]);
        
        //person is marked after voting
        request.approvals[msg.sender] = true;
        // adding person's address to approvals
        request.approvalCount++;
    }

    function finalizeRequest(uint index) public restricted {
        Request storage request = requests[index];
        
        // make sure 50% of contributors voted for yes
        require(request.approvalCount > (approversCount / 2));
        // make sure this request is not marked as complete
        require(!request.complete);
        
        // send all the money to recipient
        request.recipient.transfer(request.value);
        // update the flag to be true after paying to recipient
        request.complete = true;
    }
}