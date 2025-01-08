"use client";
import { useEffect, useState } from "react";
import { useReadContract } from "thirdweb/react";
import { client } from "./client";
import { baseSepolia } from "thirdweb/chains";
import { getContract } from "thirdweb";
import { CampaignCard } from "@/app/components/CampaignCard";
import { CROWDFUNDING_FACTORY } from "./constants/contracts";

export default function Home() {
  const [contract, setContract] = useState(null);
  const [campaigns, setCampaigns] = useState([]);
  const [isLoading, setIsLoading] = useState(true);

  // Fetch the contract asynchronously
  useEffect(() => {
    async function fetchContract() {
      try {
        const contractInstance = await getContract({
          client,
          chain: baseSepolia,
          address: CROWDFUNDING_FACTORY,
        });
        setContract(contractInstance);
      } catch (error) {
        console.error("Failed to fetch contract:", error);
      }
    }
    fetchContract();
  }, []);

  // Fetch campaign data
  useEffect(() => {
    if (!contract) return;

    async function fetchCampaigns() {
      try {
        setIsLoading(true);
        const result = await contract.call(
          "getAllCamp",
          [] // Pass any required parameters
        );
        setCampaigns(result);
      } catch (error) {
        console.error("Failed to fetch campaigns:", error);
      } finally {
        setIsLoading(false);
      }
    }

    fetchCampaigns();
  }, [contract]);

  return (
    <main className="mx-auto max-w-7xl px-4 mt-4 sm:px-6 lg:px-8">
      <div className="py-10">
        <h1 className="text-4xl font-bold mb-4">Campaigns:</h1>
        <div className="grid grid-cols-3 gap-4">
          {isLoading ? (
            <p>Loading campaigns...</p>
          ) : campaigns.length > 0 ? (
            campaigns.map((campaign) => (
              <CampaignCard
                key={campaign.campAddress}
                campaignAddress={campaign.campAddress}
              />
            ))
          ) : (
            <p>No Campaigns</p>
          )}
        </div>
      </div>
    </main>
  );
}
