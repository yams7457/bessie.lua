m = midi.connect()

m.event = function(data)   
  local d = midi.to_msg(data)
  if d.type == "note_on" then
      if #played_notes >= 4 then
        for k in pairs (played_notes) do
          played_notes[k] = nil
        end
      end
      played_notes[#played_notes + 1] = d.note % 12
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
new_chord = 0

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

function key (n,z)
  if n == 2 and z == 1 then
    for k in pairs (played_notes) do
      played_notes[k] = nil
    end
  end
end

function tell_me_what_i_played()
  if #played_notes == 4 then
    print(chord_table[played_notes[1]][played_notes[2]][played_notes[3]][played_notes[4]])
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
    note_options[3][i] = (played_notes[i] + 1) % 12
    note_options[2][i] = (played_notes[i] - 1) % 12
    note_options[1][i] = played_notes[i]
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
  new_chord = limited_chord_choices[math.random(1, #limited_chord_choices)]
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

function redraw()
  screen.clear()
  screen.move(0,40)
  screen.level(15)
  screen.text(chord_table[played_notes[1]][played_notes[2]][played_notes[3]][played_notes[4]])
  screen.move(60,40)
  screen.text(new_chord)
  for i = 1,4 do
    screen.move(i * 10, 10)
    screen.text(bottom_to_top[i])
  end
  screen.update()
end