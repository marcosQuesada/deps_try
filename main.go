package main

import(
    "fmt"
    "github.com/marcosQuesada/GO-practices/lru"
)

func main(){
 	l := lru.Init(19)
 	fmt.Println("fooo", l)
}
