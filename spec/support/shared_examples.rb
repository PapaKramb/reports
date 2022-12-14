require 'rspec/mocks'
RSpec.shared_examples 'localized model' do |attrs|
  [:ru].map do |locale|
    # TODO: this code is meant to test all locales, but there is a problem with
    # switching locale on fly, so only first locale is checked
    I18n.with_locale(locale) do
      I18n.locale = locale
      (described_class.new.attributes.keys - %w[created_at updated_at id type storage lft rgt parent_id ancestry position] + attrs.to_a).map do |key|
        key = key.gsub('_id', '').gsub('_cents', '')
        next if key =~ /service/
        it "#{described_class.name}##{key} should have #{locale} locale" do
          translation_missing = I18n.t("activerecord.attributes.#{described_class.name.underscore}.#{key}").include?('translation missing') &&
              I18n.t("activerecord.attributes.#{described_class.base_class.name.underscore}.#{key}").include?('translation missing') &&
              I18n.t("attributes.#{described_class.base_class.name.underscore}.#{key}").include?('translation missing')
          expect(translation_missing).to be false
        end
      end
      it "#{described_class.name}#model should have #{locale} locale" do
        translation_missing = I18n.t("activerecord.models.#{described_class.name.underscore}.one").include?('translation missing') &&
            I18n.t("activerecord.models.#{described_class.name.underscore}.other").include?('translation missing')
        expect(translation_missing).to be false
      end
    end
  end
end
RSpec.shared_examples 'factorized model' do |_attrs|
  it 'has valid factory' do
    expect(FactoryBot.build(described_class.to_s.underscore.to_sym)).to be_valid
    create(described_class.to_s.underscore.to_sym)
  end
end
RSpec::Matchers.define :be_the_same_time_as do |expected|
  match do |actual|
    expect(expected.strftime('%Y-%m-%dT%H:%M:%S%z').in_time_zone).to eq(actual.strftime('%Y-%m-%dT%H:%M:%S%z').in_time_zone)
  end
end