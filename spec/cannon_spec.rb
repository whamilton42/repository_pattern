require 'spec_helper'
require 'cannon'

describe Cannon do

  let(:cannon) do
    described_class.new(weight: weight,
                        length: length,
                        bore: bore,
                        last_fired_at: last_fired_at)
  end

  let(:weight) { 150 }
  let(:length) { 10 }
  let(:bore) { 60 }
  let(:last_fired_at) { nil }

  describe '#range' do
    subject { cannon.range }

    context 'for Big Bertha' do
      it 'matches the specs provided by the manual' do
        expect(subject).to eq(1760.1584592265924)
      end
    end
  end

end
