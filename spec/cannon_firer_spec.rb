require 'spec_helper'
require 'cannon_firer'
require 'cannon'

describe CannonFirer do

  let(:cannon_repository) { double('cannon_repository').as_null_object }
  let(:cannon) { Cannon.new(weight: 1, length: 1, bore: 1, last_fired_at: nil) }
  let(:target) { double('target').as_null_object }

  let(:cannon_firer) do
    described_class.new(cannon_repository)
  end

  describe '#fire' do
    let(:time) { Time.now }
    subject do
      -> { cannon_firer.fire(cannon, target, time) }
    end

    it { should change { cannon.last_fired_at }.to(time) }

    it 'destroys the target' do
      subject.call
      expect(target).to have_received(:destroy)
    end

    it 'persist the cannon' do
      expect(cannon_repository).to receive(:persist) do |cannon|
        expect(cannon.last_fired_at).to eq(time)
      end
      subject.call
    end
  end

end