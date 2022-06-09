require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:type) }
  end

  describe 'scopes' do
    describe '.search_by_name' do
      context 'When records are present' do
        let!(:event) { create(:event, :co_berlin, name: 'Dummy') }

        it do
          records = Event.search_by_name(event.name)

          expect(records).to include(event)
        end
      end

      context 'When records are not present' do
        let!(:event) { create(:event, :co_berlin, name: 'Dummy') }

        it do
          records = Event.search_by_name(SecureRandom.hex(6))

          expect(records).not_to include(event)
        end
      end
    end

    describe '.search_by_site' do
      context 'When records are present' do
        let!(:event) { create(:event, :visit_berlin) }

        it do
          records = Event.search_by_site(event.type)

          expect(records).to include(event)
        end
      end

      context 'When records are not present' do
        let!(:event) { create(:event, :visit_berlin) }

        it do
          records = Event.search_by_site('CoBerlin')

          expect(records).not_to include(event)
        end
      end
    end

    describe '.search_by_date' do
      context 'When records are present' do
        let!(:event) { create(:event, :visit_berlin, start_date: Date.current - 3.days) }

        it do
          records = Event.search_by_date(event.start_date)

          expect(records).to include(event)
        end
      end

      context 'When records are not present' do
        let!(:event) { create(:event, :visit_berlin, start_date: Date.current - 3.days) }

        it do
          records = Event.search_by_date(Date.current - 1.day)

          expect(records).not_to include(event)
        end
      end
    end
  end
end
