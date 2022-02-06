defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def generate(filename \\ "report.csv") do
    order_list = build_order_list()
    filename|>
    File.write( order_list)
  end

  defp build_order_list() do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.map(fn booking -> booking_string(booking) end)
    |> IO.inspect()
  end

  defp booking_string(%Booking{user_id: user_id, local_origin: local_origin, local_destination: local_destination, complete_date: complete_date}), do: "#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
end
