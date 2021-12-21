m = midi.connect()

m.event = function(data)   
  local d = midi.to_msg(data)
  if d.type == "note_on" then
      if tab.count(played_notes) >= 4 then
        for k in pairs (played_notes) do
          played_notes[k] = nil
        end
      end
      if not table_has(played_notes, d.note % 12) then
      played_notes[tab.count(played_notes) + 1] = d.note % 12
      end
    for k,v in spairs(played_notes, function(t,a,b) return t[b] > t[a] end) do
      bottom_to_top[k] = v
    end
    if #played_notes >= 4 then
      tell_me_what_i_played()
    end
  end
end

played_notes = {0, 4, 7, 9}
bottom_to_top = {0, 4, 7, 9}
chord_table = {}
new_chord_choices = {}
limited_chord_choices = {}
new_chord = "CM7"
reverse_chord_table = {}
reverse_chord_table["1"] = "0"

--here's some diminished chords
  reverse_chord_table["C°  Eb°  Gb°  A°"] = "0 3 6 9" 
  reverse_chord_table["Db°  E°  G°  Bb°"] = "1 4 7 10" 
  reverse_chord_table["D°  F°  Ab°  B°"] = "2 5 8 11" 

--here's some dominant chords
  reverse_chord_table["C7"] = "0 4 7 10" 
  reverse_chord_table["Db7"] = "1 5 8 11" 
  reverse_chord_table["D7"] = "0 2 6 9" 
  reverse_chord_table["Eb7"] = "1 3 7 10" 
  reverse_chord_table["E7"] = "2 4 8 11"  
  reverse_chord_table["F7"] = "0 3 5 9" 
  reverse_chord_table["Gb7"] = "1 4 6 10" 
  reverse_chord_table["G7"] = "2 5 7 11" 
  reverse_chord_table["Ab7"] = "0 3 6 8" 
  reverse_chord_table["A7"] = "1 4 7 9"
  reverse_chord_table["Bb7"] = "2 5 8 10" 
  reverse_chord_table["B7"] = "3 6 9 11"  
  
--here's some major 7 chords
  reverse_chord_table["CM7"] =  "0 4 7 11" 
  reverse_chord_table["DbM7"] = "0 1 5 8" 
  reverse_chord_table["DM7"] = "1 2 6 9"   
  reverse_chord_table["EbM7"] = "2 3 7 10" 
  reverse_chord_table["EM7"] = "3 4 8 11" 
  reverse_chord_table["FM7"] = "0 4 5 9"
  reverse_chord_table["GbM7"] = "1 5 6 10" 
  reverse_chord_table["GM7"] = "2 6 7 11" 
  reverse_chord_table["AbM7"] = "0 3 7 8" 
  reverse_chord_table["AM7"] = "1 4 8 9" 
  reverse_chord_table["BbM7"] = "2 5 9 10" 
  reverse_chord_table["BM7"] = "3 6 10 11" 
  
--here's some major 6 chords
  reverse_chord_table["CM6"] = "0 4 7 9" 
  reverse_chord_table["DbM6"] = "1 5 8 10" 
  reverse_chord_table["DM6"] = "2 6 9 11" 
  reverse_chord_table["EbM6"] = "0 3 7 10" 
  reverse_chord_table["EM6"] = "1 4 8 11" 
  reverse_chord_table["FM6"] = "0 2 5 9" 
  reverse_chord_table["GbM6"] = "1 3 6 10" 
  reverse_chord_table["GM6"] = "2 4 7 11" 
  reverse_chord_table["AbM6"] = "0 3 5 8" 
  reverse_chord_table["AM6"] = "1 4 6 9" 
  reverse_chord_table["BbM6"] = "2 5 7 10" 
  reverse_chord_table["BM6"] = "3 6 8 11" 
  
--here's some minor 6 chords
  reverse_chord_table["C-6"] = "0 3 7 9" 
  reverse_chord_table["Db-6"] = "1 4 8 10" 
  reverse_chord_table["D-6"] = "2 5 9 11" 
  reverse_chord_table["Eb-6"] = "0 3 6 10" 
  reverse_chord_table["E-6"] = "1 4 7 11" 
  reverse_chord_table["F-6"] = "0 2 5 8" 
  reverse_chord_table["Gb-6"] = "1 3 6 9" 
  reverse_chord_table["G-6"] = "2 4 7 10" 
  reverse_chord_table["Ab-6"] = "3 5 8 11" 
  reverse_chord_table["A-6"] = "0 4 6 9" 
  reverse_chord_table["Bb-6"] = "1 5 7 10" 
  reverse_chord_table["B-6"] = "2 6 8 11" 
  
--here's some 7b5 chords
  reverse_chord_table["C7b5"] = "0 4 6 10" 
  reverse_chord_table["Db7b5"] = "1 5 7 11" 
  reverse_chord_table["D7b5"] = "0 2 6 8" 
  reverse_chord_table["Eb7b5"] = "1 3 7 9" 
  reverse_chord_table["E7b5"] = "2 4 8 10" 
  reverse_chord_table["F7b5"] = "3 5 9 11" 
  reverse_chord_table["Gb7b5"] = "0 4 6 10" 
  reverse_chord_table["G7b5"] = "1 5 7 11" 
  reverse_chord_table["Ab7b5"] = "0 2 6 8" 
  reverse_chord_table["A7b5"] = "1 3 7 9" 
  reverse_chord_table["Bb7b5"] = "2 4 8 10" 
  reverse_chord_table["B7b5"] = "3 5 9 11" 
  
--here's some minM7 chords

  reverse_chord_table["CminM7"] = "0 3 7 11" 
  reverse_chord_table["DbminM7"] = "0 1 4 8" 
  reverse_chord_table["DminM7"] = "1 2 5 9" 
  reverse_chord_table["EbminM7"] = "2 3 6 10" 
  reverse_chord_table["EminM7"] = "3 4 7 11"  
  reverse_chord_table["FminM7"] = "0 4 5 8"  
  reverse_chord_table["GbminM7"] = "1 5 6 9" 
  reverse_chord_table["GminM7"] = "2 6 7 10" 
  reverse_chord_table["AbminM7"] = "3 7 8 11" 
  reverse_chord_table["AminM7"] = "0 4 8 9"  
  reverse_chord_table["BbminM7"] = "1 5 9 10"  
  reverse_chord_table["BminM7"] = "2 6 10 11" 
  
--here's some M7#5 chords

  reverse_chord_table["CM7#5"] = "0 4 8 11" 
  reverse_chord_table["DbM7#5"] = "0 1 5 9" 
  reverse_chord_table["DM7#5"] = "1 2 6 10" 
  reverse_chord_table["EbM7#5"] = "2 3 7 11" 
  reverse_chord_table["EM7#5"] = "0 3 4 8" 
  reverse_chord_table["FM7#5"] = "1 4 5 9" 
  reverse_chord_table["GbM7#5"] = "2 5 6 10" 
  reverse_chord_table["GM7#5"] = "3 6 7 11" 
  reverse_chord_table["AbM7#5"] = "0 4 7 8"
  reverse_chord_table["AM7#5"] = "1 5 8 9"
  reverse_chord_table["BbM7#5"] = "2 6 9 10"
  reverse_chord_table["BM7#5"] = "3 7 10 11" 
  
  
note_options = {}
for i = 1,3 do
  note_options[i] = {}
  for j = 1,4 do
    note_options[i][j] = {0}
  end
end

for i = 0, 11 do
  chord_table[i] = {}
  for j = 0, 11 do
    chord_table[i][j] = {}
    for k = 0, 11 do
      chord_table[i][j][k] = {}
      for l = 0, 11 do
        chord_table[i][j][k][l] = 1
      end
    end
  end
end

--here's some diminished chords
chord_table[0][3][6][9] = "C°, Eb°, Gb°, A°"
chord_table[1][4][7][10] = "Db°, E°, G°, Bb°"
chord_table[2][5][8][11] = "D°, F°, Ab°, B°"

--here's some dominant chords
chord_table[0][4][7][10] = "C7"
chord_table[1][5][8][11] = "Db7"
chord_table[0][2][6][9] = "D7"
chord_table[1][3][7][10] = "Eb7"
chord_table[2][4][8][11] = "E7"
chord_table[0][3][5][9] = "F7"
chord_table[1][4][6][10] = "Gb7"
chord_table[2][5][7][11] = "G7"
chord_table[0][3][6][8] = "Ab7"
chord_table[1][4][7][9] = "A7"
chord_table[2][5][8][10] = "Bb7"
chord_table[3][6][9][11] = "B7"

--here's some major 7 chords
chord_table[0][4][7][11] = "CM7"
chord_table[0][1][5][8] = "DbM7"
chord_table[1][2][6][9] = "DM7"
chord_table[2][3][7][10] = "EbM7"
chord_table[3][4][8][11] = "EM7"
chord_table[0][4][5][9] = "FM7"
chord_table[1][5][6][10] = "GbM7"
chord_table[2][6][7][11] = "GM7"
chord_table[0][3][7][8] = "AbM7"
chord_table[1][4][8][9] = "AM7"
chord_table[2][5][9][10] = "BbM7"
chord_table[3][6][10][11] = "BM7"

--here's some major 6 chords
chord_table[0][4][7][9] = "CM6"
chord_table[1][5][8][10] = "DbM6"
chord_table[2][6][9][11] = "DM6"
chord_table[0][3][7][10] = "EbM6"
chord_table[1][4][8][11] = "EM6"
chord_table[0][2][5][9] = "FM6"
chord_table[1][3][6][10] = "GbM6"
chord_table[2][4][7][11] = "GM6"
chord_table[0][3][5][8] = "AbM6"
chord_table[1][4][6][9] = "AM6"
chord_table[2][5][7][10] = "BbM6"
chord_table[3][6][8][11] = "BM6"

--here's some minor 6 chords
chord_table[0][3][7][9] = "C-6"
chord_table[1][4][8][10] = "Db-6"
chord_table[2][5][9][11] = "D-6"
chord_table[0][3][6][10] = "Eb-6"
chord_table[1][4][7][11] = "E-6"
chord_table[0][2][5][8] = "F-6"
chord_table[1][3][6][9] = "Gb-6"
chord_table[2][4][7][10] = "G-6"
chord_table[3][5][8][11] = "Ab-6"
chord_table[0][4][6][9] = "A-6"
chord_table[1][5][7][10] = "Bb-6"
chord_table[2][6][8][11] = "B-6"

--here's some 7b5 chords
chord_table[0][4][6][10] = "C7b5"
chord_table[1][5][7][11] = "Db7b5"
chord_table[0][2][6][8] = "D7b5"
chord_table[1][3][7][9] = "Eb7b5"
chord_table[2][4][8][10] = "E7b5"
chord_table[3][5][9][11] = "F7b5"
chord_table[0][4][6][10] = "Gb7b5"
chord_table[1][5][7][11] = "G7b5"
chord_table[0][2][6][8] = "Ab7b5"
chord_table[1][3][7][9] = "A7b5"
chord_table[2][4][8][10] = "Bb7b5"
chord_table[3][5][9][11] = "B7b5"

--here's some minM7 chords

chord_table[0][3][7][11] = "CminM7"
chord_table[0][1][4][8] = "DbminM7"
chord_table[1][2][5][9] = "DminM7"
chord_table[2][3][6][10] = "EbminM7"
chord_table[3][4][7][11] = "EminM7"
chord_table[0][4][5][8] = "FminM7"
chord_table[1][5][6][9] = "GbminM7"
chord_table[2][6][7][10] = "GminM7"
chord_table[3][7][8][11] = "AbminM7"
chord_table[0][4][8][9] = "AminM7"
chord_table[1][5][9][10] = "BbminM7"
chord_table[2][6][10][11] = "BminM7"

--here's some M7#5 chords

chord_table[0][4][8][11] = "CM7#5"
chord_table[0][1][5][9] = "DbM7#5"
chord_table[1][2][6][10] = "DM7#5"
chord_table[2][3][7][11] = "EbM7#5"
chord_table[0][3][4][8] = "EM7#5"
chord_table[1][4][5][9] = "FM7#5"
chord_table[2][5][6][10] = "GbM7#5"
chord_table[3][6][7][11] = "GM7#5"
chord_table[0][4][7][8] = "AbM7#5"
chord_table[1][5][8][9] = "AM7#5"
chord_table[2][6][9][10] = "BbM7#5"
chord_table[3][7][10][11] = "BM7#5"

function key (n,z)
  if n == 2 and z == 1 then
    for k in pairs (played_notes) do
      played_notes[k] = nil
    end
  end
end

function tell_me_what_i_played()
  if tab.count(played_notes) == 4 then
    print(chord_table[bottom_to_top[1]][bottom_to_top[2]][bottom_to_top[3]][bottom_to_top[4]])
    calculate_a_new_chord()
    redraw()
  end
end

function calculate_a_new_chord()
  for i = 1, 3 do
    new_chord_choices[i] = {}
    for j = 1, 3 do
      new_chord_choices[i][j] = {}
      for k = 1, 3 do
        new_chord_choices[i][j][k] = {}
        for l = 1, 3 do
          new_chord_choices[i][j][k][l] = {0,0,0,0}
        end
      end
    end
  end
  for i = 1,4 do
    note_options[3][i] = (bottom_to_top[i] + 1) % 12
    note_options[2][i] = (bottom_to_top[i] - 1) % 12
    note_options[1][i] = bottom_to_top[i]
  end
  for i = 1,3 do
    for j = 1,3 do
      for k = 1,3 do
        for l = 1,3 do
          new_chord_choices[i][j][k][l] = {note_options[i][1], note_options[j][2], note_options[k][3], note_options[l][4]}
            for m,v in spairs(new_chord_choices[i][j][k][l], function(t,a,b) return t[b] > t[a] end) do
               new_chord_choices[i][j][k][l][m] = v
            end
            if chord_table[new_chord_choices[i][j][k][l][1]][new_chord_choices[i][j][k][l][2]][new_chord_choices[i][j][k][l][3]][new_chord_choices[i][j][k][l][4]] ~= 1 then
              table.insert(limited_chord_choices, chord_table[new_chord_choices[i][j][k][l][1]][new_chord_choices[i][j][k][l][2]][new_chord_choices[i][j][k][l][3]][new_chord_choices[i][j][k][l][4]])
            end
        end
      end
    end
  end
  new_chord = limited_chord_choices[math.random(1, tab.count(limited_chord_choices))]
end


function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return i, t[keys[i]]
        end
    end
end

function table_has(tab, val)
  for index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end

function redraw()
  screen.clear()
  screen.font_face(7)
  screen.font_size(12)
  screen.move(0,30)
  screen.level(15)
  screen.text(chord_table[bottom_to_top[1]][bottom_to_top[2]][bottom_to_top[3]][bottom_to_top[4]])
  screen.move(0,50)
  screen.text(new_chord)
  for i = 1,4 do
    screen.move((i - 1) * 10, 10)
    screen.text(bottom_to_top[i])
  end
    screen.move (86, 10)
    screen.text(reverse_chord_table[new_chord])
  screen.update()
end
