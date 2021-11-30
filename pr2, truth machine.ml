let rec truth_machine value = if value = 0 then print_string "0\n" else (print_string "1\n";truth_machine 1) ;;

let x =read_int ();;
truth_machine x ;;