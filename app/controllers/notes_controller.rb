class NotesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_note, only:[:edit, :update, :destroy]
  before_action :set_product

  def index
    # @notes = Note.all
    @notes = policy_scope(Note)
  end

  def new
    # @note = Note.new
    @note = current_user.notes.new
    authorize @note
  end

  def create
    # @note = Note.new(note_params)
    # @note.product = @product
    # @note.product.user = @user
    # if @note.save
    #   redirect_to product_notes_path(@product)
    # else
    #   render :new
    # end
    @note = current_user.notes.new(note_params)
    authorize @note
    if @note.save
      redirect_to product_notes_path(@product), notice: 'Note created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    # if @note.update(note_params)
    #   redirect_to product_path(@product)
    # else
    #   render :update
    # end
    if @note.update(note_params)
      redirect_to product_path(@product), notice: 'Note updated!'
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    redirect_to product_path(@product), notice: "Note deleted"
  end

  def confirmation
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_note
    if @note.nil?
      flash.alert = 'No notes for this product yet'
    else
      @note = Note.find(params[:product_id])
    end
  end

  def note_params
    params.require(:note).permit(:schedule, :product_id, :user_id)
  end
end
