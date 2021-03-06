class PaymentsController < ApplicationController
  # load_and_authorize_resource
  before_action :check_acount, only: [:kakao]
  # require 'rqrcode'
  require 'rest-client'

  def new
    @total_amount = params[:total_amount]
  end
  
  def kakao
    @total_amount = params[:total_amount].to_i
    url = 'https://kapi.kakao.com/v1/payment/ready'
    header = {content_type: 'application/x-www-form-urlencoded',
              Authorization:"KakaoAK #{ENV['KAKAO_AK']}"}
    payload = {
        cid: "TC0ONETIME",
        partner_order_id: 0,
        partner_user_id: 0,
        item_name: "one-two",
        quantity: 1,
        total_amount: @total_amount,
        tax_free_amount: @total_amount,
        approval_url: "https://a7bdfbf884dd4cb29015d3a81ab52fea.vfs.cloud9.us-east-2.amazonaws.com/payments/kakao/success",
        cancel_url: "https://a7bdfbf884dd4cb29015d3a81ab52fea.vfs.cloud9.us-east-2.amazonaws.com/payments/kakao/cancel",
        fail_url: "https://a7bdfbf884dd4cb29015d3a81ab52fea.vfs.cloud9.us-east-2.amazonaws.com/payments/kakao/fail"
    }
  
    res = RestClient.post(url, payload, headers = header)
    @res = JSON.parse(res)
    @@tid = @res["tid"]
    redirect_to @res["next_redirect_pc_url"]
    
  end
  
  def kakao_success
    url = 'https://kapi.kakao.com/v1/payment/approve'
    header = {content_type: 'application/x-www-form-urlencoded',
              Authorization:"KakaoAK #{ENV['KAKAO_AK']}" }
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
  
  def kakao_cancel
    
  end
  
  def kakao_fail
    
  end
  
  # def toss
  #   url = "https://pay.toss.im/api/v1/payments"
  #   header = {content_type: 'application/json'}
  #   payload = {
  #       "orderNo" => "2015072012211",
  #       "amount"=> 10000,
  #       "amountTaxFree"=> 0,
  #       "productDesc" => "테스트 결제",
  #       "apiKey" => "sk_test_apikey1234567890",
  #       "expiredTime" => "2015-07-20 16:21:00",
  #       "resultCallback" => "https://a7bdfbf884dd4cb29015d3a81ab52fea.vfs.cloud9.us-east-2.amazonaws.com/payments/result"
  #   }
  #   @res = RestClient.post(url, payload)
  # end
  
  # def create
    
  # end
  
  # def show
  #   @qr = RQRCode::QRCode.new( 'https://github.com/whomwah/rqrcode', :size => 4, :level => :h )
  # end
  
  private
  def check_acount
    unless 1000 <= params[:total_amount].to_i and params[:total_amount].to_i <= 1000000
      redirect_to my_cart_path, :flash => { :error => "1,000원 이상 1,000,000원 이하의 금액만 결제 가능합니다." } 
    end 
      
  end
  # def set_total_amount
    
  # end
end

