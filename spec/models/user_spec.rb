require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.presentable_roles' do
    subject { described_class.presentable_roles }

    it 'returns an array of the roles' do
      expect(subject).to match_array(
        [
          [:basic, 0],
          [:admin, 1]
        ]
      )
    end
  end

  describe '#selected_role' do
    let!(:user) { User.create(role: described_class::ROLES[:basic]) }

    subject { user.selected_role }

    it 'returns an array of the assigned role' do
      expect(subject).to eq(['basic', 0])
    end
  end

  describe '#admin?' do
    let!(:user) { User.create(role: role) }

    subject { user.admin? }

    context 'when user has admin role' do
      let(:role) { described_class::ROLES[:admin] }

      it { is_expected.to be_truthy }
    end

    context 'when user does not have admin role' do
      let(:role) { described_class::ROLES[:basic] }

      it { is_expected.to be_falsey }
    end
  end

  describe '#basic?' do
    let!(:user) { User.create(role: role) }

    subject { user.basic? }

    context 'when user has basic role' do
      let(:role) { described_class::ROLES[:basic] }

      it { is_expected.to be_truthy }
    end

    context 'when user does not have basic role' do
      let(:role) { described_class::ROLES[:admin] }

      it { is_expected.to be_falsey }
    end
  end
end
