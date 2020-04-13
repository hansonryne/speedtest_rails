# frozen_string_literal: true

class SpeedTestsController < ApplicationController
  MAX_RECORDS_SHOWN = 30
  before_action :set_speed_test, only: %i[show edit update destroy]

  # GET /speed_tests
  # GET /speed_tests.json
  def index
    @records_to_show = params[:max_records]
    @records = SpeedTest.all.order(created_at: 'desc').limit(@records_to_show)
    @pings = SpeedTest.get_pings(@records.to_a)
    @download_speeds = SpeedTest.get_download_speed(@records.to_a)
    @upload_speeds = SpeedTest.get_upload_speed(@records.to_a)
    @bar_chart = SpeedTest.all.group(:server).count
  end

  # GET /speed_tests/1
  # GET /speed_tests/1.json
  def show; end

  # GET /speed_tests/new
  def new
    @speed_test = SpeedTest.new
  end

  # GET /speed_tests/1/edit
  def edit; end

  # POST /speed_tests
  # POST /speed_tests.json
  def create
    @speed_test = SpeedTest.new(speed_test_params)

    respond_to do |format|
      if @speed_test.save
        format.html { redirect_to @speed_test, notice: 'Speed test was successfully created.' }
        format.json { render :show, status: :created, location: @speed_test }
      else
        format.html { render :new }
        format.json { render json: @speed_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /speed_tests/1
  # PATCH/PUT /speed_tests/1.json
  def update
    respond_to do |format|
      if @speed_test.update(speed_test_params)
        format.html { redirect_to @speed_test, notice: 'Speed test was successfully updated.' }
        format.json { render :show, status: :ok, location: @speed_test }
      else
        format.html { render :edit }
        format.json { render json: @speed_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /speed_tests/1
  # DELETE /speed_tests/1.json
  def destroy
    @speed_test.destroy
    respond_to do |format|
      format.html { redirect_to speed_tests_url, notice: 'Speed test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_speed_test
    @speed_test = SpeedTest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def speed_test_params
    params.require(:speed_test).permit(:ping, :upload, :download, :server, :max_records)
  end
end
