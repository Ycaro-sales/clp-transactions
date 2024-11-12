class TransfersController < ApplicationController
  before_action :authorize_request

  def transfer_pix
    receiver_account_id = PixKey.find(params[:pix_key]).account_id
    if receiver_account_id == nil then
      render json: { errors: "pix key not found" }, status: :invalid
      return
    end

    @transfer = Transfer.new() do |t|
      t.transfer_type = 0
      t.value = params[:value]
      t.sender_id = @current_user.id
      t.receiver_id = receiver_account_id
      t.date = Time.now
    end

    # TODO: confirmar validacao
    if !@transfer.valid? then
      render json: { errors: "Invalid transfer data" }, status: 400
      return
    end

    @transfer.save

    render json: @transfer
  end

  def create_pixkey
    if PixKey.find(params["pix_key"]) != nil then
      render json: { errors: "Pix Key already exists" }
      return
    end

    @pixkey = PixKey.new do |t|
      t.key = params["pix_key"]
      t.account = @current_user.account
    end

    render json: @pixkey
  end

  def transfer_ted
    @receiver_account = Account.find_or_create_by(id: params[:receiver_id])

    @transfer = Transfer.new() do |t|
      t.transfer_type = 1
      t.value = params[:value]
      t.sender_id = @current_user.id
      t.receiver_id = @receiver_account.id
    end

    # TODO: confirmar validacao
    if !@transfer.valid? then
      render json: { errors: "Invalid transfer data" }, status: 400
      return
    end

    @transfer.save

    render json: @transfer
  end

  def transfer_doc
    @transfer = Transfer.new() do |t|
      t.transfer_type = 2
      t.value = params[:value]
      t.sender_id = @current_user.id
      t.receiver_id = params[:receiver_id]
      t.date = Time.now
    end

    if !@transfer.valid? then
      render json: { errors: "Invalid transfer data" }, status: 400
      return
    end

    @transfer.save

    render json: @transfer
  end

  def user_transfers_list
    @transfers = Transfers.where("sender_id = :user_id or receiver_id = :user_id", { userid: @current_user.id })

    render json: @transfers, status: :ok
  end

  # TODO: Renderizar comprovante como PDF
  def get_transfer_receipt
    @transfer = Transfer.find(params[:id])
    render json: @transfer
  end

  def list
    @transfers = Transfer.all
    render json: @transfers, status: :ok
  end

  def show
    @transfer = Transfer.find(params[:id])
    render json: @transfer
  end

  def delete
    @transfer = Transfer.find(params[:id])
    @transfer.delete
    render json: { Message: "deletion successful" }, status: :ok
  end
end
