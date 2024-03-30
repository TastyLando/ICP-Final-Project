# icp final project
This code contains an actor simulating a blood donation system. Its functionality consists of the following components:

Person (Kişi) and PersonNeed (Kişi İhtiyacı) Types: Represent data structures for individuals who can donate blood and those who need blood donations, respectively. These structures include fields such as the person's ID, name, city of residence, blood group, and eligibility to donate.

DonatedBlood (Bağışlanan Kan) Type: This data structure is used for blood donations. It includes fields for the donor's ID, blood group, amount donated, and whether the donation has been delivered.

NeedRequest (İhtiyaç Talebi) Type: Represents requests made by individuals in need of blood. Each request includes a request ID, requester's ID, required blood group, and the ID of a potential donor to fulfill the request.

Functions:

# createDonationRequest: 
Enables an individual to make a blood donation request. If the person has a contagious disease, the request is rejected.
# youNeedBlood: 
Checks whether an individual needs blood.
# fulfillNeedRequest: 
Facilitates the fulfillment of a blood donation request by a donor.
# canFulfillNeedRequest: 
Checks whether a specified donor can fulfill a particular blood donation request.
# Data Structures:

personsNeed: List of individuals in need of blood.
persons: List of individuals capable of donating blood.
donatedBloods: List of blood donations made.
needRequests: List of blood donation requests.
The purpose of this code is to define and manage the basic functionalities and data structures of a blood donation system. The code can be used to process blood donation requests, find potential donors, and track blood donations.


If you want to start working on your project right away, you might want to try the following commands:

```bash
cd icp/
dfx help
dfx canister --help
```

## Running the project locally

If you want to test your project locally, you can use the following commands:

```bash
# Starts the replica, running in the background
dfx start --background

# Deploys your canisters to the replica and generates your candid interface
dfx deploy
```

Once the job completes, your application will be available at `http://localhost:4943?canisterId={asset_canister_id}`.

If you have made changes to your backend canister, you can generate a new candid interface with

```bash
npm run generate
```

at any time. This is recommended before starting the frontend development server, and will be run automatically any time you run `dfx deploy`.

If you are making frontend changes, you can start a development server with

```bash
npm start
```

Which will start a server at `http://localhost:8080`, proxying API requests to the replica at port 4943.

### Note on frontend environment variables

If you are hosting frontend code somewhere without using DFX, you may need to make one of the following adjustments to ensure your project does not fetch the root key in production:

- set`DFX_NETWORK` to `ic` if you are using Webpack
- use your own preferred method to replace `process.env.DFX_NETWORK` in the autogenerated declarations
  - Setting `canisters -> {asset_canister_id} -> declarations -> env_override to a string` in `dfx.json` will replace `process.env.DFX_NETWORK` with the string in the autogenerated declarations
- Write your own `createActor` constructor
