class TransfersController < ApplicationController
  before_action :authorize_request

  def transfer_pix
    receiver_account_id = PixKey.find(params[:pix_key]).account_id

    @transfer = Transfer.new() do |t|
      t.transfer_type = 0
      t.value = params[:value]
      t.sender_id = @current_user.id
      t.receiver_id = receiver_account_id
      t.date = Time.now
    end

    # TODO: confirmar validacao
    if !@transfer.valid? then
    end

    @transfer.save

    render json: @transfer
  end

  def transfer_ted
    @transfer = Transfer.new() do |t|
      t.transfer_type = 1
      t.value = params[:value]
      t.sender_id = @current_user.id
      t.receiver_id = params[:receiver_id]
      t.date = Time.now
    end

    # TODO: confirmar validacao
    if !@transfer.valid? then
    end

    @transfer.save

    render json: @transfer
  end

  def transfer_doc
    @transfer = Transfer.new() do |t|
      t.transfer_type = 1
      t.value = params[:value]
      t.sender_id = @current_user.id
      t.receiver_id = params[:receiver_id]
      t.date = Time.now
    end

    # TODO: confirmar validacao
    if !@transfer.valid? then
    end

    @transfer.save

    render json: @transfer
  end

  def user_transfers_list
    @transfers = Transfers.where("sender_id = :user_id or receiver_id = :userid", { userid: @current_user.id })

    render json: @transfers, status: :ok
  end

  # TODO: mostrar transferencias do usuario
  def user_transfers_show
    # if @transfer.
    # @transfer = Transfer.find(params[:id])
  end

  # TODO: Renderizar comprovante como PDF
  def get_transfer_receipt
    # renderizar pdf
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
    render json: {}, status: :ok
  end
end
