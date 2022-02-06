defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def generate(filename \\ "report.csv") do
    order_list = build_order_list()
    filename|>
    File.write( order_list)
  end

  def generate(filename \\ "report.csv", from_date, to_date) do
    order_list = build_order_list(from_date, to_date)
    filename|>
    File.write( order_list)
  end

  defp filter_by_date(booking_list, from_date, to_date) do
    booking_list
    |> Enum.filter(fn (order) ->
      order.complete_date >= from_date
      && order.complete_date <= to_date
    end
    )
  end

  defp build_order_list() do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.map(fn booking -> booking_string(booking) end)
    |> IO.inspect()
  end
  defp build_order_list(from_date, to_date) do
    BookingAgent.list_all()
    |> Map.values()
    |> filter_by_date(from_date, to_date)
    |> Enum.map(fn booking -> booking_string(booking) end)
    |> IO.inspect()
  end

  defp booking_string(%Booking{user_id: user_id, local_origin: local_origin, local_destination: local_destination, complete_date: complete_date}), do: "#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
end
