# Cost requested
COST = 180
# Funding
EEF_FUND = 8623.80
# CUSEC cost
TICKET_COST = 60.0
# Hotel cost
ROOM_COST = 484.66
STUDENT_PER_ROOM = 4
NOT_MIXED_ROOM = true
# Bus cost
BUS_COST = 1356.0
BUS_SEATS = 48
SEATS_FOR_LUGGAGE = 4

def hotel_cost(student_count)
  room_count = (student_count.to_f / STUDENT_PER_ROOM.to_f).ceil
  if NOT_MIXED_ROOM then
    room_count += 1
  end
  puts "Room count #{room_count}"
  (ROOM_COST * room_count).round(2)
end

def bus_cost(student_count)
  usable_seats = BUS_SEATS - SEATS_FOR_LUGGAGE;
  qty_bus_needed = (student_count.to_f / usable_seats.to_f).ceil
  (qty_bus_needed * BUS_COST).round(2)
end

def ticket_cost(student_count)
  (TICKET_COST * student_count).round(2)
end

def total_cost(student_count)
  expenses = hotel_cost(student_count) +
    ticket_cost(student_count) +
    bus_cost(student_count)
  funding = EEF_FUND
  (expenses - funding).round(2)
end

1.upto 176 do |count|
  cost = total_cost(count)
  per_student = [0,(cost / count.to_f).round(2)].max
  percent = ((COST.to_f - per_student)/COST.to_f * 100).ceil
  puts "At #{count} students, we get #{percent}% refund (costs #{per_student}$ each)"
end
