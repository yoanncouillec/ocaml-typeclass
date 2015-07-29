a.out: functor.cmo #functor2.cmo
	ocamlc $^

%.cmo: %.ml
	ocamlc -c $^

clean:
	rm -rf a.out *.cm*