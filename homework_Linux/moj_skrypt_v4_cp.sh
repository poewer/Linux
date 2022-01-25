#!/bin/bash



#rozpoczecie programu od wyboru logowania/rejestracji
echo "Wybierz opcje (1:2): "
echo '
1.Login
2.zarejestruj sie
'




while  [[ [$choice != 1]  ||  [$choice != 2] ]];
do 
        read choice

    #new line
    echo

    case $choice in
        "1")
                #Logoawnie --->
                echo "Logowanie: "
                echo    #new line
                echo "Podaj Login: "  
                read login_login    #wprowadzenie loginu
                echo    #new line
                echo "Podaj haslo: "  
                read login_haslo    #wprowadzenie hasła
                # <---!

                #sprawdzanie poprawności danych w bazie danych
                check_login=$(grep "^Login: $login_login$" base64) #sprawdzanie czy login istnieje w bazie
                check_haslo=$(grep "^Haslo: $login_haslo$" base64) #sprawdzanie czy haslo istnieje w bazie 
                
                echo    "
                            $check_login
                            Login: $login_login

                            $check_haslo
                            Haslo :$login_haslo
                        "

                    if [ "$check_login" == "Login: $login_login" ] && [ "$check_haslo" == "Haslo: $login_haslo" ] ;
                    then
                        echo "poprawnie sie zalogowales"
                        echo    #new line     

                        #Dodatkowe informacje --->
                        #Kodaowanie i dekodowanie loginu/hasla base64
                        login_login_base64_code=$(printf "$login_login" | base64);
                        login_login_base64_decode=$(printf "$login_login_base64_code" | base64 -d);

                        login_haslo_base64_code=$(printf "$login_haslo" | base64);
                        login_haslo_base64_decode=$(printf "$login_haslo_base64_code" | base64 -d);

                        #Sprawdzanie poprawności kodowania base64 i dekodowania
                        echo "Login code base64: $login_login_base64_code"
                        echo "Login decode base64: $login_login_base64_decode"

                        echo    #new line

                        echo "Haslo code base64: $login_haslo_base64_code"
                        echo "Haslo decode base64: $login_haslo_base64_decode"

                        #Sprawdzanie poprawnosci podanych danych
                        echo "Login: $login_login  haslo: $login_haslo"
                        # <---

                                #opcje dostepu po zalogowaniu
                                echo    "
                                        1) Dodaj dane
                                        2) Modyfikuj dane
                                        3) Usun dane !Usuniecie calego konta!
                                        4) Wyswietl dane
                                        5) Zakoncz skrypt
                                        "                                        
                                        
                                        while read choice;
                                        do
                                            case $choice in
                                                1)   
                                                    echo   "podaj co chcesz wprowadzic: 
                                                            1)Imie
                                                            2)Nazwisko
                                                            3)Login
                                                            4)Haslo
                                                            5)email
                                                            6)Tip
                                                            7)zapisz
                                                            8)Wyswietl Dane
                                                            9)exit
                                                            "


                                                                
                                                                check_array=($(grep -n "$login_login_base64_decode Array=(.*" base64)) #konwertowanie znaków wartości tablicy z pliku base64 do tablicy lokalcnej 
                                                                while read choice ;
                                                                do    
                                                                    case $choice in
                                                                    1)                                                                  
                                                                        if [ ${check_array[2]} == 0 ];
                                                                        then                                                                           
                                                                            echo "Imie: "
                                                                            read Imie   #wprowadzanie imienia do tablicy
                                                                            array_database=("$Imie" "${check_array[3]}" "$login_login_base64_decode" "$login_haslo_base64_decode" "${check_array[6]}" "${check_array[7]}")                
                                                                            echo "Podaj opcje: "
                                                                        else
                                                                            echo "Nie mozesz podac imienia"
                                                                            echo "( Imie: ${check_array[2]} )"
                                                                        fi
                                                                        ;;
                                                                    2)     
                                                                        if [ ${check_array[3]} == 0 ];
                                                                        then
                                                                            
                                                                            echo "Nazwisko: "
                                                                            read Nazwisko   #wprowadzanie nazwiska do tablicy
                                                                            array_database=(${check_array[2]} "$Nazwisko" "$login_login_base64_decode" "$login_haslo_base64_decode" ${check_array[6]} ${check_array[7]})                
                                                                            echo "Podaj opcje: "                                                                            
                                                                        else
                                                                            echo "Nie mozesz podac nazwiska"
                                                                            echo "( Nazwisko: ${check_array[3]} )"

                                                                        fi                                                                        
                                                                        ;;
                                                                    3)  echo "Nie mozesz wprowadzic loginu";;                                                                        
                                                                    4)  echo "Nie mozesz wprowadzic hasla ale mozesz je zmienic";;                                                                        
                                                                    5)
                                                                        if [ ${check_array[6]} == 0 ];
                                                                        then                                                                        
                                                                            echo "email: "
                                                                            read email    #wprowadzanie email do tablicy
                                                                            array_database=("${check_array[2]}" "${check_array[3]}" "$login_login_base64_decode" "$login_haslo_base64_decode" "$email" "${check_array[7]}")                
                                                                            echo "Podaj opcje: "                                                                            
                                                                        else
                                                                            echo "Nie mozesz podac emaila"
                                                                            echo "( Email: ${check_array[6]} )"
                                                                        fi
                                                                        ;;
                                                                    6)  
                                                                        if [ ${check_array[7]} == 0 ];
                                                                        then                                            
                                                                            echo "tip: "
                                                                            read tip    #wprowadzanie tipu do tablicy
                                                                            array_database=(${check_array[2]} ${check_array[3]} "$login_login_base64_decode" "$login_haslo_base64_decode" ${check_array[6]} "$tip")                
                                                                            echo "Podaj opcje: "
                                                                        else
                                                                            echo "Nie mozesz podac tip"
                                                                            echo "( Tip: ${check_array[7]} )"                                                                            
                                                                        fi
                                                                        ;;
                                                                    7) 
                                                                        echo "Dane Profilu: ${array_database[*]}"
                                                                        sed -i "s/$login_login_base64_decode Array=(.*/$login_login_base64_decode Array=(${array_database[*]})/" base64
                                                                        ;;
                                                                    8)  
                                                                        echo "Wyświetl Dane"
                                                                        grep "^$login_login_base64_decode Array=(.*" base64
                                                                        ;;                                                         
                                                                    9)   
                                                                        break ;;                                                                                                                    
                                                                    *)  echo "Nie ma takiej opcji do tablicy!!!"                                                                    
                                                                        ;;      
                                                                    esac
                                                                done
                                                    break
                                                    ;;
                                                2)  echo "modyfikuj dane"
                                                    break
                                                    ;;
                                                3)  echo "Usun dane !Usuniecie calego konta!" 
                                                    break
                                                    ;;
                                                4)  grep "^$login_login_base64_decode Array=(.*" base64;;                                                    
                                                5)  ;;                                                
                                                *)  echo "nie ma takiej opcji modyfikacji!!!"                                                      
                                                    ;;                                                  
                                            esac
                                        done                                                

                    else
                        if [ "$check_login" != "Login: $login_login" ];
                        then
                            echo "Uzytkownik o takim Loginie nie istnieje"
                        else
                            echo "Podales zly login lub haslo"

                        fi

                    fi
            break
            ;;
        "2")    
                #Rejestracja --->
                echo "Rejestracja: " 
                echo    #new line
                echo "Podaj Login: "  
                read rej_login    #wprowadzenie loginu
                echo
                echo "Podaj haslo: "  
                read rej_haslo    #wprowadzenie hasła     
                # <---!

                if  grep "^Login: $rej_login$" base64  ; #Sprawdzamy czy użytkownik o takim Loginie znajduje się w bazie 
                then
                    echo "takie konto juz istnieje"
                else
                    #Kodaowanie i dekodowanie loginu/hasla base64 --->

                    #Login
                    rej_login_base64_code=$(printf "$rej_login" | base64);
                    rej_login_base64_decode=$(printf "$rej_login_base64_code" | base64 -d);
                    #Hasło
                    rej_haslo_base64_code=$(printf "$rej_haslo" | base64);
                    rej_haslo_base64_decode=$(printf "$rej_haslo_base64_code" | base64 -d);

                    # <---!

                    #zapisywanie login/haslo do pliku base64
                    save_Login_rej=$(echo Login: "$rej_login_base64_decode" >> base64 && echo Login base64: "$rej_login_base64_code" >> base64 );
                    save_Login_rej=$(echo Haslo: "$rej_haslo_base64_decode" >> base64 && echo Haslo base64: "$rej_haslo_base64_code" >> base64 );
                    create_array=$(echo "$rej_login_base64_decode"" Array=(0 0 $rej_login_base64_decode $rej_haslo_base64_decode 0 0)" >> base64 && echo >> base64 );

                    #wykonanie poleceń
                    echo "$save_Login_rej"
                    echo "$save_Haslo_rej"
                    echo "$create_array"

                    echo "!Pomyslna rejestracja!"
                    break
                fi
                
            ;;
        *)
                echo "Nie poprawny wybor"
                echo #new line
            ;;
    esac
done
