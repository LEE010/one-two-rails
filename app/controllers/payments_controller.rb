class PaymentsController < ApplicationController
  require 'rqrcode'
  require 'rest-client'

  def new
    @total_amount = params[:total_amount]
  end
  
  def kakao
    url = 'https://kapi.kakao.com/v1/payment/ready'
    header = {content_type: 'application/x-www-form-urlencoded',
              Authorization:'KakaoAK 7c1a7f46d8d4299aba89d608d98a3641'}
    payload = {
        cid: "TC0ONETIME",
        partner_order_id: 0,
        partner_user_id: 0,
        item_name: "one-two",
        quantity: 1,
        total_amount: 1000000,
        tax_free_amount: 1000000,
        approval_url: "https://a7bdfbf884dd4cb29015d3a81ab52fea.vfs.cloud9.us-east-2.amazonaws.com/payments/kakao/success",
        cancel_url: "https://a7bdfbf884dd4cb29015d3a81ab52fea.vfs.cloud9.us-east-2.amazonaws.com/payments/kakao/cancel",
        fail_url: "https://a7bdfbf884dd4cb29015d3a81ab52fea.vfs.cloud9.us-east-2.amazonaws.com/payments/kakao/fail"
    }
    @total_amount = params[:total_amount].to_i
    res = RestClient.post(url, payload, headers = header)
    @res = JSON.parse(res)
    @@tid = @res["tid"]
    redirect_to @res["next_redirect_pc_url"]
    
  end
  
  def kakao_success
    url = 'https://kapi.kakao.com/v1/payment/approve'
    header = {content_type: 'application/x-www-form-urlencoded',
              Authorization:'KakaoAK 7c1a7f46d8d4299aba89d608d98a3641'}
    payload = {
        cid: "TC0ONETIME",
        tid: @@tid,
        partner_order_id: 0,
        partner_user_id: 0,
        pg_token: params[:pg_token],
       }
    begin
      res = RestClient.post(url, payload, headers = header)
      @res = JSON.parse(res)
    rescue => e
      e.response
    end
    
  end
  
  def toss
    url = "https://pay.toss.im/api/v1/payments"
    header = {content_type: 'application/json'}
    payload = {
        "orderNo" => "2015072012211",
        "amount"=> 10000,
        "amountTaxFree"=> 0,
        "productDesc" => "테스트 결제",
        "apiKey" => "sk_test_apikey1234567890",
        "expiredTime" => "2015-07-20 16:21:00",
        "resultCallback" => "https://a7bdfbf884dd4cb29015d3a81ab52fea.vfs.cloud9.us-east-2.amazonaws.com/payments/result"
    }
    @res = RestClient.post(url, payload)
  end
  
  def create
    
  end
  
  def show
    @qr = RQRCode::QRCode.new( 'https://github.com/whomwah/rqrcode', :size => 4, :level => :h )
  end
  
end

