defmodule Flightex do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Users.CreateOrUpdate, as: CreateOrUpdateUser
  alias Flightex.Bookings.CreateOrUpdate, as: CreateOrUpdateBooking
  alias Flightex.Bookings.Report

  def start_agents do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  defdelegate create_or_update_user(params), to: CreateOrUpdateUser, as: :call
  defdelegate create_or_update_booking(params), to: CreateOrUpdateBooking, as: :call

  def generate_report(from_date, to_date), do: Report.generate(from_date, to_date)
end
