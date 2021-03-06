require 'spec_helper'

describe GoogleCloudVision do
  let(:images) do
    [
      { image: '../text.png', detection: 'TEXT_DETECTION' },
      { image: '../sushi.jpg', detection: 'LABEL_DETECTION' }
    ]
  end

  context 'creating valid JSON' do
    let(:gcv) { GoogleCloudVision::Classifier.new('1234567890', images) }

    it 'returns valid json' do
      expect(gcv.send(:requests, images)).to be_an_instance_of(String)
    end

    it 'includes type of detection' do
      detection_type = gcv.send(:request, images.first)[:features][:type]
      expect(detection_type).to eq('TEXT_DETECTION')
    end
  end

  it 'does not query google in tests' do
    uri = URI('https://vision.googleapis.com/v1/images:annotate?key=1234567890')
    response = Net::HTTP.get(uri)
    expect(response).to be_an_instance_of(String)
  end

  it 'has a version number' do
    expect(GoogleCloudVision::VERSION).not_to be nil
  end
end
