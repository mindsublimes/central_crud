class ContactsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_contact, only: [:show, :update, :destroy]

  def index
    @contacts = Contact.all
    respond_to do |format|
      format.json { render json: @contacts }
      format.csv do
        send_data @contacts.to_csv, filename: "contacts.csv", disposition: "attachment"
      end
    end
  end

  def show
    if @contact
      render json: @contact
    else
      render json: { error: "Contact not found" }, status: :not_found
    end
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def update
    if @contact
      if @contact.update(contact_params)
        render json: @contact
      else
        render json: { errors: @contact.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Contact not found" }, status: :not_found
    end
  end

  def destroy
    if @contact
      @contact.destroy
      render json: {ok: 'deleted successfully'}
    else
      render json: { error: "Contact not found" }, status: :not_found
    end
  end

  private

  def set_contact
    @contact = Contact.find_by id: params[:id]
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :phone, :email)
  end
end
