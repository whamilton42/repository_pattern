require 'spec_helper'
require 'cannon_repository'
require 'persistence_adaptors/sequel'

describe CannonRepository do
  let(:adaptor) { SequelPersistenceAdaptor.new(DB, :cannons) }
  let(:cannon_repository) { described_class.new(adaptor) }

  let(:last_fired_at) { nil }
  let(:cannon_attributes) do
    {
      weight: 50,
      length: 4,
      bore: 12,
      last_fired_at: last_fired_at
    }
  end

  describe '#persist' do
    let(:cannon) { Cannon.new(cannon_attributes) }

    subject do
      -> { cannon_repository.persist(cannon) }
    end

    context 'cannon has not already been persisted' do
      it { should change { DB[:cannons].count }.by(1) }
    end

    context 'cannon has already been persisted' do
      let!(:cannon) do
        id = DB[:cannons].insert(cannon_attributes)
        Cannon.new(cannon_attributes.merge(id: id))
      end

      it { should_not change { DB[:cannons].count } }

      it 'changes values' do
        time = 5.minutes.ago
        cannon.last_fired_at = time
        cannon_repository.persist(cannon)
        cannon_from_db = DB[:cannons].where(id: cannon.id).first
        expect(cannon_from_db[:last_fired_at]).to eq(time)
      end
    end
  end

  describe '#find_ready_to_fire' do
    subject do
      -> { cannon_repository.find_ready_to_fire }.call
    end

    let!(:cannon) do
      id = DB[:cannons].insert(cannon_attributes)
      Cannon.new(cannon_attributes.merge(id: id))
    end

    context 'cannon has never fired' do
      let(:last_fired_at) { nil }

      it { should include(cannon) }
    end

    context 'cannon fired in the last minute' do
      let(:last_fired_at) { 30.seconds.ago }

      it { should_not include(cannon) }
    end

    context 'cannon fired over a minute ago' do
      let(:last_fired_at) { 2.minutes.ago }

      it { should include(cannon) }
    end
  end

end