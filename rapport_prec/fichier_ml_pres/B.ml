open A

let print_t1 (var_exemple : t1) =
	match var_exemple with
	|Exemple_int x -> printf "%d" x
	|Exemple_char x -> printf "%c" x
