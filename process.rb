def func(resurs, process, resurs_array, process_array)
  processes = []
  resurses = []
  html = String.new
  p = resurs.to_i
  r = process.to_i
  resurs_array.each_with_index  do |i, index|
    #puts "Запас ресурса #{index}: "
    push_value = i.to_i
    resurses.push([push_value, push_value])
  end

  process_array.each_with_index  do |i, index|
    res = []
    res_need = []
    resurses.each_with_index  do |j, j_index|
      #puts "Процессу #{index} выделено R #{j_index}: "
      p i[1].values[0].values[j_index]
      inp = i[1].values[0].values[j_index].to_i
      #puts "Процессу #{index} необходимо R #{j_index}: "
      p i[1].values[1].values[j_index]
      inp_need = i[1].values[1].values[j_index].to_i

      res.push inp
      res_need.push inp_need
      resurses[j_index][1] = resurses[j_index][1] - inp #free
    end
    res_push = [res, res_need] # 0 - alloc;  1 - neccer
    processes[index] = res_push

  end


  not_check = true
  safe = 0

  count_processes = processes.length
  while (not_check) do

    count_safe_in_while = 0
    processes.each_with_index do |i, i_index|
      unless i == "safe"
        res_status = false
        i[0].each_with_index  do |r, index|
          if (i[1][index] <= r + resurses[index][1] )
           html+= "<p>Процесс #{i_index} R#{index}: Нет тупика</p>"
            res_status = true
          else
            html+= "<p>Процесс #{i_index} R#{index}: Тупик</p>"
            res_status = false
          end
        end
        if res_status
          count_safe_in_while+=1
          safe+=1
          i[0].each_with_index  do |r, index|
            resurses[index][1]+=r
            html+= "<p>Ресурсу R#{index} возвращается #{r} от процесса #{i_index}</p>"
          end
          processes[i_index] = "safe"
        end
      end
    end
    not_check = false if count_safe_in_while == 0
  end

  $a = ""
  if count_processes == safe
    $a+= '<p class="alert alert-success">Система безопасна</p>'
  else
    $a+= '<p class="alert alert-danger">Система не безопасна'
  end
  return $a+html
end
