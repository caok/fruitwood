# encoding: utf-8
require 'spec_helper'

describe EventHelper do
  describe '#date_merge' do
    let(:event) { build :event, start_date: "#{year}-12-30", end_date: "#{year}-12-30" }
    let(:year) { Time.zone.now.year }
    let(:next_year) { year + 1 }
    subject { helper.date_merge(event) }

    context 'when year is current year' do
      context 'when date is the same' do
        it { should == '12月30日(一)' }
      end
      context 'when date is not the same' do
        before { event.end_date = event.end_date.change(day: 31) }
        it { should == '12月30日(一) - 12月31日(二)' }
      end
    end

    context 'when year is not current year' do
      before do
        event.start_date = event.start_date.change(year: next_year)
        event.end_date = event.end_date.change(year: next_year)
      end
      context 'when date is the same' do
        it { should == "#{next_year}年12月30日(二)" }
      end
      context 'when date is not the same' do
        before { event.end_date = event.end_date.change(day: 31) }
        it { should == "#{next_year}年12月30日(二) - #{next_year}年12月31日(三)" }
      end
    end
  end
end
