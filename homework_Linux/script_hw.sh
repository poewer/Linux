#!/bin/bash
    $first_name
    $last_name
    $email
    $tip

    #array_database=($first_name, $last_name, $email, $login_login, $login_haslo, $tip) tymczasowy komentarz


echo "Wybierz opcje (1:2): "
echo '
1.Login
2.zarejestruj sie
'
read choice

#new line
echo

if [ $choice == '1' ];
then
    echo "Logowanie: "
    echo    #new line

    echo "Podaj Login: "  
    read login_login    #wprowadzenie loginu
    echo
    echo "Podaj haslo: "  
    read login_haslo    #wprowadzenie hasła
     
    echo #new line

    check_login=$(grep "^Login: $login_login$" base64) #sprawdzanie czy login istnieje w bazie
    check_haslo=$(grep "^Haslo: $login_haslo$" base64) #sprawdzanie czy haslo istnieje w bazie 


    if [ "$check_login" == "Login: $login_login" ] && [ "$check_haslo" == "Haslo: $login_haslo" ] ;
    then
        echo "poprawnie sie zalogowales"
        echo    #new line  


        #Kodaowanie i dekodowanie loginu/hasla base64
        login_login_base64_code=$(printf "$login_login" | base64);
        login_login_base64_decode=$(printf "$login_login_base64_code" | base64 -d);

        login_haslo_base64_code=$(printf "$login_haslo" | base64);
        login_haslo_base64_decode=$(printf "$login_haslo_base64_code" | base64 -d);

        #Sprawdzanie poprawności kodowania base64 i dekodowania
        echo "Login code base64: $login_login_base64_code"
        echo "Login decode base64: $login_login_base64_decode"
        echo
        echo "Haslo code base64: $login_haslo_base64_code"
        echo "Haslo decode base64: $login_haslo_base64_decode"
    
        echo #new line 

        #Sprawdzanie poprawnosci podanych danych
        echo "Login: $login_login  haslo: $login_haslo"

        echo    #new line

        #opcje dostepu po zalogowaniu
        echo    "
                1) Dodaj dane
                2) Modyfikuj dane
                3) Usun dane !Usuniecie calego konta!
                4) Wyswietl dane
                5) Zakoncz skrypt
                "
        read choice
        case $choice in 
            "1") echo   "podaj co chcesz wprowadzic: 
                            1)Imie
                            2)Nazwisko
                            3)Login
                            4)Haslo
                            5)Tip
                        "
                        read choice
                        #wprowadzanie danych do tablicy 
                        case $choice in 
                            "1" ) echo "Edit imie";;
                            "2" ) echo "Edit Nazwisko";;
                            "3" ) echo "! Nie mozesz dodac loginu !";;
                            "4" ) echo "! Nie mozesz dodac hasla ale mozesz je zmienic !";;
                            "5" ) echo "Edit Tip";;
                        esac               
                ;;

            "2") echo "Dodaj dane";;

            "3") echo "Dodaj dane";;

            "4") grep "$rej_login_base64_decode"'_array=*' base64
                 echo ${array_database[*]}
                ;;

            "5")  ;;
        esac   

    else    
        if [ "$check_login" != "Login: $login_login" ];
        then
            echo "Uzytkownik o takim Loginie nie istnieje"
        else
            echo "Podales zly login lub haslo"
        
        fi
    fi

else

    echo "Rejestracja: " 
    echo    #new line

    echo "Podaj Login: "  
    read rej_login    #wprowadzenie loginu
    echo
    echo "Podaj haslo: "  
    read rej_haslo    #wprowadzenie hasła
     
     

    if  grep "^Login: $rej_login$" base64  ; 
    then
        echo "takie konto juz istnieje"
    else
    #Kodaowanie i dekodowanie loginu/hasla base64
    rej_login_base64_code=$(printf "$rej_login" | base64);
    rej_login_base64_decode=$(printf "$rej_login_base64_code" | base64 -d);

    rej_haslo_base64_code=$(printf "$rej_haslo" | base64);
    rej_haslo_base64_decode=$(printf "$rej_haslo_base64_code" | base64 -d);

    #zapisywanie login/haslo do pliku base64
    save_Login_rej=$(echo Login: "$rej_login_base64_decode" >> base64 && echo Login base64: "$rej_login_base64_code" >> base64 );
    save_Login_rej=$(echo Haslo: "$rej_haslo_base64_decode" >> base64 && echo Haslo base64: "$rej_haslo_base64_code" >> base64 );
    create_array=$(echo "$rej_login_base64_decode""_array=()" >> base64 && echo >> base64 );

    #wykonanie polecen
    echo "$save_Login_rej"
    echo "$save_Haslo_rej"
    echo "$create_array"
    
    echo "!Pomyslna rejestracja!"
    fi
    


fi