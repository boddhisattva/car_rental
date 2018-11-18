# frozen_string_literal: true

describe Actor do
  describe '#details' do
    context 'given an actor with name, payment type and amount related details' do
      it 'displys these details as part of a collection' do
        actor = Actor.new('owner', 2100)

        expect(actor.details).to eq(who: 'owner', type: 'credit', amount: 2100)
      end
    end
  end
end
