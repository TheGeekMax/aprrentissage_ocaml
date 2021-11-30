(*fonctions annexe*)
let rec print_list l =
  match l with
  |[] -> failwith "vide !"
  |[a] -> print_endline a;
  |t::q -> print_endline t; print_list q;;

let print_arr l = let rec print_list_of_array l =
  match l with
  |[] -> failwith "vide !"
  |[a] -> print_endline a;
  |t::q -> print_string t; print_list_of_array q in
  print_list_of_array (Array.to_list l);print_string "\n";;

(*partie du code qui recupere les mots dans le fichier text et le met dans une liste*)   
let read_text file =
  let ic = open_in file in
    let rec read_line ic li=
      try
      read_line ic ((input_line ic)::(li));
      with e ->
        close_in ic;
        li;
      in
        read_line ic [];;

(*partie qui recupere un charactère de l'utilisateur*)
let get_caracter ()= String.make 1 ((read_line ()).[0]);;

(*partie initialisation du jeu*)
let word_init word = Array.make (String.length word) "*";;

let find_letter l word letter=
  let inside = ref (-1) in
  let rec itterate l letter word i =
    if i < (Array.length l) then
    begin
        if (String.make 1 word.[i]) = letter && l.(i) = "*" then
        begin
          l.(i) <- letter;
          inside := !inside + 1;
          itterate l letter word (i+1);
        end
        else
        itterate l letter word (i+1);
      end
    else
      !inside;
    
  in
  itterate l letter word 0;;
        
      

(*main*)
Random.self_init ();;

let game words_list = 
  let choosen_word = List.nth words_list (Random.int (List.length words_list)) in
  let nb_to_find = ref (String.length choosen_word) in
  let letters = word_init choosen_word in
  let life = ref 15 in
  let rec play () =
    print_string "mot : ";
    print_arr letters;
    print_string "\nvie restante : ";
    print_int !life;
    print_string "\nlettre : ";
    let letter = get_caracter() in
    match (find_letter letters choosen_word letter) with
  | (-1) -> begin life := !life -1;if !life > 0 then begin print_endline "\n\n\n";play () ;end else begin print_endline "\nPERDU !\nle mot était"; print_endline choosen_word; end end
    | nb -> begin nb_to_find := !nb_to_find - (1 + nb );if !nb_to_find >0 then begin print_endline "\n\n\n";play ();end else begin print_endline "\nGAGNEE \nle mot était :";print_endline choosen_word; end end 
  in play ();;



let words = read_text "mots.txt";;
game words;;