let game = [|[|1;2;3|];[|4;0;5|];[|7;8;6|]|];;
Random.self_init ();;

let rec transpose tab =
  let rec first_elmts tab i=
    if i < (Array.length tab) then
      Array.append [|tab.(i).(0)|] (first_elmts tab (i+1))
    else
     [||]
    in
  let rec rest_elmts tab i=
    if i < (Array.length tab) then
      Array.append [|Array.sub tab.(i) 1 ((Array.length tab.(i)) - 1)|] (rest_elmts tab (i+1))
    else
     [||]
    in
  let rec final_tran tab i=
    if i < (Array.length tab) then
      Array.append [|(first_elmts tab 0)|] (final_tran (rest_elmts tab 0) (i+1))
    else
     [||]
    in
    final_tran tab 0;;

let rec right tab i =
  let rec mv_line line i =
    if i < ((Array.length line) -1) then
    match line.(i+1) with
    | 0 -> begin line.(i+1) <- line.(i);  line.(i) <- 0; mv_line line (i+1) end;
    | _ -> mv_line line (i+1);
  in 
  if i < (Array.length tab) then
    begin
      mv_line tab.(i) 0;
      right tab (i+1);
    end;;

let rec left tab i =
  let rec mv_line line i =
    if i > 0 then
    match line.(i-1) with
    | 0 -> begin line.(i-1) <- line.(i);  line.(i) <- 0; mv_line line (i-1) end;
    | _ -> mv_line line (i-1);
  in 
  if i < (Array.length tab) then
    begin
      mv_line tab.(i) (Array.length tab -1);
      left tab (i+1);
    end;;

let up tab i =
  let rec replaceL line1 line2 i =
    if i < (Array.length line1)then
      begin
        line1.(i) <- line2.(i);
        replaceL line1 line2 (i+1);
      end
    in
  let rec replace tab1 tab2 i=
    if i < (Array.length tab1)then
      begin
        replaceL tab1.(i) tab2.(i) 0;
        replace tab1 tab2 (i+1);
      end
    in
    begin let tt = (transpose tab) in left (tt) 0; replace tab (transpose tt) 0 end;;

let down tab i =
  let rec replaceL line1 line2 i =
    if i < (Array.length line1)then
      begin
        line1.(i) <- line2.(i);
        replaceL line1 line2 (i+1);
      end
    in
  let rec replace tab1 tab2 i=
    if i < (Array.length tab1)then
      begin
        replaceL tab1.(i) tab2.(i) 0;
        replace tab1 tab2 (i+1);
      end
    in
    begin let tt = (transpose tab) in right (tt) 0; replace tab (transpose tt) 0 end;;

let print_matrix tab =
  let rec print_line line =
    let rec print_cell cell =
      match cell with
      | 0 -> print_string " ";
      | _ -> print_int cell;
    in
    Array.iter (fun t -> begin print_cell t;print_string "|"; end) line;
  in 
  begin
  print_string "+-+-+-+\n|";
  Array.iter (fun t -> begin print_line t;print_string "\n+-+-+-+\n|"; end) tab;
  print_endline "-----|\n";
  end;;

print_matrix game;;
down game 0;;
print_matrix game;;

let rec mix tab i =
  if i < 100 then
      let r = Random.int 4 in
        match r with
        | 0 -> begin up tab 0;mix tab (i+1) end;
        | 1 -> begin down tab 0;mix tab (i+1) end;
        | 2 -> begin right tab 0;mix tab (i+1) end;
        | 3 -> begin left tab 0;mix tab (i+1) end;
        | _ -> mix tab (i+1);
  else
  ();;

mix game 0;;
while true do
  begin
    print_matrix game;
    let values = (input_char stdin) in
      match values with
      |'z' -> up game 0;
      |'s' -> down game 0;
      |'q' -> left game 0;
      |'d' -> right game 0;
      |_ -> ();
  end
done;;