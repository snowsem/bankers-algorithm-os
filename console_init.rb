processes = []
resurses = []

puts "Введите кол-процессов: "
p = gets.chomp.to_i
puts "Введите кол-ресурсов: "
r = gets.chomp.to_i
(0..r-1).each do |i|
  puts "Запас ресурса #{i}: "
  push_value = gets.chop.to_i
  resurses.push([push_value, push_value])
end

(0..p-1).each do |i|
  res = []
  res_need = []
  (0..r-1).each do |j|
    puts "Процессу #{i} выделено R #{j}: "
    inp = gets.chomp.to_i
    puts "Процессу #{i} необходимо R #{j}: "
    inp_need = gets.chomp.to_i

    res.push inp
    res_need.push inp_need
    resurses[j][1] = resurses[j][1]-inp
  end
  res_push = [res, res_need] # 0 - alloc;  1 - neccer
  processes[i] = res_push

end
count_processes = processes.length

not_check = true
safe = 0
while (not_check) do

  count_safe_in_while = 0
  processes.each_with_index do |i, i_index|
    unless i == "safe"
      res_status = false
      i[0].each_with_index  do |r, index|
        if (i[1][index] <= r + resurses[index][1] )
          puts "Процесс #{i_index} R#{index}: Нет тупика"
          res_status = true
        else
          puts "Процесс #{i_index} R#{index}: Тупик"
          res_status = false
        end
      end
      if res_status
        count_safe_in_while+=1
        safe+=1
        i[0].each_with_index  do |r, index|
          resurses[index][1]+=r
          puts "Ресурсу R#{index} возвращается #{r} от процесса #{i_index}"
        end
        processes[i_index] = "safe"
      end
    end
  end
  not_check = false if count_safe_in_while == 0
end
puts "Система безопасна" if count_processes = safe
#puts count_processes
#puts safe


