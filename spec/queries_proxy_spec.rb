require "spec_helper"

describe TeamsnapRb::QueriesProxy do
  use_vcr_cassette "root"

  let(:queries_proxy) { TeamsnapRb::Collection.new(
    "http://localhost:3003", {}, TeamsnapRb::Config.new
  ).queries }

  describe "#new" do
    it "accepts an array of queries from a collection+json response and a config" do
      expect(queries_proxy).to be_a(TeamsnapRb::QueriesProxy)
    end
  end

  describe "#rels" do
    it "returns an array of the link names represented as symbols" do
      expect(queries_proxy.rels).to include(:bulk_load)
    end
  end

  describe "sending a link name to the QueriesProxy" do
    it "raises a MissingQueryParameter exception if params are missing from the query" do
      expect{queries_proxy.bulk_load}.to raise_exception(TeamsnapRb::Query::MissingQueryParameter)
    end

    it "returns a TeamsnapRB::Collection when the query executes successfully" do
      expect(queries_proxy.bulk_load(:team_id => 1)).to be_a(TeamsnapRb::Collection)
    end
  end
end
