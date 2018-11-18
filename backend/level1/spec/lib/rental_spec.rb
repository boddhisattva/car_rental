describe Rental do
  describe '#book' do
    context 'given details specific to a particular rental' do
      it 'calculates and updates the applicable price for that rental' do
        car = Car.new(1, 2000, 10)
        rental = { "id" => 1, "car_id" => 1, "start_date" => "2017-12-8", "end_date" => "2017-12-10", "distance" => 100 }
        rental = Rental.new(rental, car)

        rental.book

        expect(rental.price).to eq(7000)
      end
    end
  end

  describe "#booking_details" do
    context "given a rental with related details" do
      it "retrieves the booking details" do
        car = Car.new(1, 2000, 10)
        rental = { "id" => 1, "car_id" => 1, "start_date" => "2017-12-8", "end_date" => "2017-12-10", "distance" => 100 }
        rental = Rental.new(rental, car)

        rental.book

        expect(rental.booking_details).to eq({
          id: 1,
          price: 7000
        })
      end
    end
  end
end
