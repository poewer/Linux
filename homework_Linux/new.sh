#!/bin/bash


echo "Podaj opcje 
    1) logowanie
    2) rejestracja"
read -e 

case $REPLY in
1)
    read -p "Login: " login 
    read -p "Haslo: " haslo

    check_login=$(grep "$login" base64.txt)
    check_password=$(grep "$haslo" base64.txt)

    if  [ "$check_login" ] && [ "$check_password" ]  ;
    then
        echo "opcja dodaj/modyfikuj
              1)  imie
              2)  nazwisko
              3)  email
              4)  wskazowka
              5)  wyświetl
              6)  usun dane
              7)  wyjdź              
            "
            read -e
            case $REPLY in 
            1)
                read -p "podaj imie: " imie
                data_base=($imie $nazwisko $login $haslo $email $wskazowka)
                sed -ie "s/$login Array.*/$login Array ( ${data_base[*]} )/g" base64.txt
                echo ${data_base[@]}
                ;;
            2)
                read -p "podaj nazwisko: " nazwisko
                data_base=($imie $nazwisko $login $haslo $email $wskazowka)
                sed -ie "s/$login Array.*/$login Array ( ${data_base[*]} )/g" base64.txt
                echo ${data_base[@]}
                ;;
            3)
                read -p "podaj email: " email
                data_base=($imie $nazwisko $login $haslo $email $wskazowka)
                sed -ie "s/$login Array.*/$login Array ( ${data_base[*]} )/g" base64.txt
                echo ${data_base[@]}
                ;;
            4)
                read -p "podaj wskazówke: " wskazowka
                data_base=($imie $nazwisko $login $haslo $email $wskazowka)
                sed -ie "s/$login Array.*/$login Array ( ${data_base[*]} )/g" base64.txt
                echo ${data_base[@]}
                ;;
            5) grep "^$login Array.*"  base64.txt;;
            6) 
            login=$(echo "$login" | base64)
            sed -ie "s/^Login base64: $login/ /"  base64.txt

            login=$(echo "$login" | base64 -d)
            sed -ie "s/^Login: $login/ /"  base64.txt

            haslo=$(echo "$haslo" | base64)
            sed -ie "s/^haslo base64: $haslo/ /"  base64.txt

            haslo=$(echo "$haslo" | base64 -d)
            sed -ie "s/^haslo: $haslo/ /"  base64.txt
            
            sed -ie "s/^$login Array.*/ /"  base64.txt
            ;;
            7) exit ;;
            *) echo "nie ma takiej opcji" ;;
            esac
        else
            echo "Taki user nie istnieje"

            
    fi

;;
2)
read -p "Login: " login 
read -p "Haslo: " haslo

#zapis loginu 
login=$(echo "$login" | base64)
echo "Login base64: $login" >> base64.txt
login=$(echo "$login" | base64 -d)
echo "Login: $login" >> base64.txt

#zapis hasła 
haslo=$(echo "$haslo" | base64)
echo "haslo base64: $haslo" >> base64.txt
haslo=$(echo "$haslo" | base64 -d)
echo "haslo: $haslo" >> base64.txt
echo "$login Array" >> base64.txt
#przerwa w pliku między użytkownikami 
echo >> base64.txt
;;
*) echo "niema takiej opcji" ;;
esac