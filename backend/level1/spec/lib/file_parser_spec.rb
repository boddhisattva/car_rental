describe FileParser do
  describe "#parse" do
    context "given a file name" do
      it "returns parsed data containing cars and rentals related information" do
        file_name = "data/input.json"

        rentals = FileParser.new(file_name).parse

        expect(rentals.count).to eq(3)
      end
    end
  end
end