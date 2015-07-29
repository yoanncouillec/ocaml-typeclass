class type show = object
  method show : unit -> string
end

(* ----------------------------------- YESNO -------------------------------- *)

type yesno = Yes | No

class type iyesno = object
  inherit show
end

let show_yesno = function
  | Yes -> "Yes"
  | No -> "No"

class cyesno v : iyesno = object
  val v = v
  method show () = show_yesno v
end

(* ------------------------------------ EQ ---------------------------------- *)

class type ['a] eq = object
  method eq : 'a -> cyesno
end

(* ---------------------------------- NATURAL ------------------------------- *)

type natural = Zero | Succ of natural

let rec show_natural = function
  | Zero ->  "Zero"
  | Succ n -> "Succ (" ^ (show_natural n) ^ ")"

let rec eq_natural n n' = match (n, n') with
  | (Zero, Zero) -> Yes
  | (Succ n, Succ n') -> eq_natural n n'
  | _ -> No

class type inat = object
  inherit show
  inherit [inat] eq
  method getn : unit -> natural
end

class nat n : inat = object 
  val n = n
  method show () = show_natural n
  method eq n' = new cyesno (eq_natural n (n'#getn()))
  method getn () = n
end

(* ----------------------------------- MAIN --------------------------------- *)

let _ = 
  let o1 = new nat (Zero) in
  let o2 = new nat (Succ(Zero)) in
  print_endline (o1#show()) ;
  print_endline (o2#show()) ;
  print_endline ((o1#eq(o1))#show()) ;
  print_endline ((o1#eq(o2))#show())
