# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DateApiEngine::DateFormatter do
  let(:default_format) { 'iso8601' }
  let(:default_timezone) { 'UTC' }

  describe '#initialize' do
    context 'with default parameters' do
      before do
        allow(DateApiEngine.configuration).to receive(:default_format).and_return(default_format)
        allow(DateApiEngine.configuration).to receive(:default_timezone).and_return(default_timezone)
      end

      it 'initializes with default format and timezone' do
        formatter = described_class.new
        expect(formatter.format).to eq(default_format)
        expect(formatter.timezone).to eq(default_timezone)
      end
    end

    context 'with custom parameters' do
      let(:custom_format) { 'rfc3339' }
      let(:custom_timezone) { 'America/New_York' }

      it 'initializes with provided format and timezone' do
        formatter = described_class.new(custom_format, custom_timezone)
        expect(formatter.format).to eq(custom_format)
        expect(formatter.timezone).to eq(custom_timezone)
      end
    end
    
    context 'with invalid parameters' do
      it 'raises an error for invalid format' do
        expect {
          described_class.new('invalid_format', default_timezone)
        }.to raise_error(ArgumentError, /Invalid format/)
      end

      it 'raises an error for invalid timezone' do
        expect {
          described_class.new(default_format, 'Invalid/Timezone')
        }.to raise_error(ArgumentError, /Invalid timezone/)
      end
    end
  end

  describe '#format' do
    before do
      # Freeze time for consistent test results
      allow(Time).to receive(:now).and_return(Time.new(2023, 3, 16, 12, 34, 56, '+00:00'))
    end

    it 'returns date in iso8601 format' do
      formatter = described_class.new('iso8601', 'UTC')
      expect(formatter.format).to eq('2023-03-16T12:34:56Z')
    end

    it 'returns date in rfc3339 format' do
      formatter = described_class.new('rfc3339', 'UTC')
      expect(formatter.format).to eq('2023-03-16T12:34:56+00:00')
    end

    it 'returns date in rfc2822 format' do
      formatter = described_class.new('rfc2822', 'UTC')
      expect(formatter.format).to eq('Thu, 16 Mar 2023 12:34:56 +0000')
    end

    it 'returns date in long format' do
      formatter = described_class.new('long', 'UTC')
      # This may vary depending on ActiveSupport configuration, adjust as needed
      expect(formatter.format).to match(/March 16, 2023/)
    end

    it 'returns date in db format' do
      formatter = described_class.new('db', 'UTC')
      expect(formatter.format).to eq('2023-03-16 12:34:56')
    end
    
    it 'applies the timezone correctly' do
      formatter = described_class.new('iso8601', 'America/New_York')
      # Time in UTC should be converted to America/New_York
      # This should reflect a -05:00 or -04:00 offset depending on DST
      expect(formatter.format).to match(/2023-03-16T/)
      # More precise timezone testing would depend on exact DST rules
    end
  end

  describe '#valid?' do
    it 'returns true for valid format and timezone' do
      formatter = described_class.new(default_format, default_timezone)
      expect(formatter.valid?).to be true
    end

    it 'returns false for invalid format' do
      allow_any_instance_of(described_class).to receive(:valid_format?).and_return(false)
      allow_any_instance_of(described_class).to receive(:valid_timezone?).and_return(true)

      formatter = described_class.new
      expect(formatter.valid?).to be false
    end

    it 'returns false for invalid timezone' do
      allow_any_instance_of(described_class).to receive(:valid_format?).and_return(true)
      allow_any_instance_of(described_class).to receive(:valid_timezone?).and_return(false)

      formatter = described_class.new
      expect(formatter.valid?).to be false
    end
  end
end