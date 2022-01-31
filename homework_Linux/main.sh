#!/bin/bash

#rozpoczęcie programu od wyboru logowania/rejestracji
echo "Wybierz opcje (1:2): "
echo '
1.Login
2.zarejestruj sie
'

while  [[ [$choice != 1]  ||  [$choice != 2] ]];
do 
    read choice
    echo #new line
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


                                                                
                check_array=($(grep "$login_login_base64_decode Array=(.*" base64)) #konwertowanie znaków wartości tablicy z pliku base64 do tablicy lokalcnej 
                while read choice ;
                do    
                    case $choice in
                    1)                                                                  
                        if [ ${check_array[2]} == "0," ];
                        then                                                                           
                            echo "Imie: "
                            read Imie   #wprowadzanie imienia do tablicy
                            check_array=($(grep "$login_login_base64_decode Array=(.*" base64)) #konwertowanie znaków wartości tablicy z pliku base64 do tablicy lokalcnej / została zmodyfikowana dlatego ta czynność jest konieczna 
                            array_database=( ${check_array[2]} ${check_array[3]} $login_login_base64_decode, $login_haslo_base64_decode, ${check_array[6]} "${check_array[7]}" )
                            array_database[0]="$Imie,"
                            sed -i  -e "s/$login_login_base64_decode Array=(.*/$login_login_base64_decode Array=( ${array_database[*]} )/" base64   #zapisanie zmian w "bazie"[base64]
                            echo "Podaj opcje: "
                        else
                            echo "Nie mozesz podac imienia"
                            echo "( Imie: ${check_array[2]} )"
                        fi
                            ;;
                        2)  
                            check_array=($(grep "$login_login_base64_decode Array=(.*" base64)) #konwertowanie znaków wartości tablicy z pliku base64 do tablicy lokalcnej / została zmodyfikowana dlatego ta czynność jest konieczna   
                            if [ ${check_array[3]} == "0," ];
                            then
                                
                                echo "Nazwisko: "
                                read Nazwisko   #wprowadzanie nazwiska do tablicy
                                check_array=($(grep "$login_login_base64_decode Array=(.*" base64)) #konwertowanie znaków wartości tablicy z pliku base64 do tablicy lokalcnej / została zmodyfikowana dlatego ta czynność jest konieczna
                                array_database=( ${check_array[2]} ${check_array[3]} $login_login_base64_decode $login_haslo_base64_decode ${check_array[6]} "${check_array[7]}" )
                                array_database[1]="$Nazwisko,"
                                sed -i  -e "s/$login_login_base64_decode Array=(.*/$login_login_base64_decode Array=( ${array_database[*]} )/" base64   #zapisanie zmian w "bazie"[base64]
                                echo "Podaj opcje: "                                                                            
                            else
                                echo "Nie mozesz podac nazwiska"
                                echo "( Nazwisko: ${check_array[3]} )"
                            fi                                                                        
                            ;;
                        3)  echo "Nie mozesz wprowadzic loginu";;                                                                        
                        4)  echo "Nie mozesz wprowadzic hasla ale mozesz je zmienic";;                                                                        
                        5)
                            check_array=($(grep "$login_login_base64_decode Array=(.*" base64)) #konwertowanie znaków wartości tablicy z pliku base64 do tablicy lokalcnej / została zmodyfikowana dlatego ta czynność jest konieczna
                            if [ "${check_array[6]}" == "0," ];
                            then                                                                        
                                echo "email: "
                                read email    #wprowadzanie email do tablicy
                                array_database=( ${check_array[2]} ${check_array[3]} $login_login_base64_decode, $login_haslo_base64_decode, ${check_array[6]} "${check_array[7]}" )
                                array_database[4]="$email,"
                                sed -i  -e "s/$login_login_base64_decode Array=(.*/$login_login_base64_decode Array=( ${array_database[*]} )/" base64   #zapisanie zmian w "bazie"[base64]                                                                                                                                                                     
                                echo "Podaj opcje: "                                                                            
                            else
                                echo "Nie mozesz podac emaila"
                                echo "( Email: ${check_array[6]} )"
                            fi
                            ;;
                        6)  
                            check_array=($(grep "$login_login_base64_decode Array=(.*" base64)) #konwertowanie znaków wartości tablicy z pliku base64 do tablicy lokalcnej / została zmodyfikowana dlatego ta czynność jest konieczna
                            if [ "${check_array[7]}" == "0," ];
                            then                                            
                                echo "tip: "
                                read -r tip    #wprowadzanie tipu do tablicy
                                check_array=($(grep "$login_login_base64_decode Array=(.*" base64)) #konwertowanie znaków wartości tablicy z pliku base64 do tablicy lokalcnej / została zmodyfikowana dlatego ta czynność jest konieczna
                                array_database=( ${check_array[2]} ${check_array[3]} $login_login_base64_decode, $login_haslo_base64_decode, ${check_array[6]} "${check_array[7]}" )                                                    
                                array_database[5]=$(echo "$tip" | sed -e "s/ /_/g")
                                sed -i  -e "s/$login_login_base64_decode Array=(.*/$login_login_base64_decode Array=( ${array_database[*]} )/" base64   #zapisanie zmian w "bazie"[base64]
                                echo "Podaj opcje: "
                            else
                                echo "Nie mozesz podac tip"
                                echo "( Tip: ${check_array[7]} )" | sed "s/_/ /g"                                                                          
                            fi
                            ;;
                        7) 
                            echo "Dane Profilu: ${array_database[*]}"
                            sed -i "s/$login_login_base64_decode Array=(.*/$login_login_base64_decode Array=( ${array_database[*]} )/" base64 #zapisanie zmian w "bazie"[base64]
                            echo "Podaj opcje: "
                            ;;
                        8)  
                            echo "Wyświetl Dane"
                            grep "^$login_login_base64_decode Array=(.*" base64 | sed "s/_/ /g"
                            ;;                                                         
                        9)   
                            break ;;                                                                                                                    
                        *)  echo "Nie ma takiej opcji do tablicy!!!"                                                                    
                            ;;      
                    esac
                done
                break
                ;;
                2)  
                    echo "modyfikuj dane"
                    echo   "podaj co chcesz modyfikowac: 
                            1)Imie
                            2)Nazwisko
                            3)Login
                            4)Haslo
                            5)email
                            6)Tip                                                                        
                            7)Wyswietl Dane
                            8)exit
                            "
                        while read -e ;
                        do  
                            case $REPLY in 
                            1) 
                                echo "Imie: "
                                read Imie   #wprowadzanie imienia do tablicy
                                check_array=($(grep "$login_login_base64_decode Array=(.*" base64)) #konwertowanie znaków wartości tablicy z pliku base64 do tablicy lokalcnej / została zmodyfikowana dlatego ta czynność jest konieczna 
                                array_database=( ${check_array[2]} ${check_array[3]} $login_login_base64_decode, $login_haslo_base64_decode, ${check_array[6]} "${check_array[7]}" )
                                array_database[0]="$Imie,"
                                sed -i  -e "s/$login_login_base64_decode Array=(.*/$login_login_base64_decode Array=( ${array_database[*]} )/" base64   #zapisanie zmian w "bazie"[base64]
                                echo "Podaj opcje: "
                            ;;
                            2) 
                                echo "Nazwisko: "
                                read Nazwisko   #wprowadzanie nazwiska do tablicy
                                check_array=($(grep "$login_login_base64_decode Array=(.*" base64)) #konwertowanie znaków wartości tablicy z pliku base64 do tablicy lokalcnej / została zmodyfikowana dlatego ta czynność jest konieczna
                                array_database=( ${check_array[2]} ${check_array[3]} $login_login_base64_decode $login_haslo_base64_decode ${check_array[6]} "${check_array[7]}" )
                                array_database[1]="$Nazwisko,"
                                sed -i  -e "s/$login_login_base64_decode Array=(.*/$login_login_base64_decode Array=( ${array_database[*]} )/" base64   #zapisanie zmian w "bazie"[base64]
                                echo "Podaj opcje: " 
                            ;;
                            3) echo "Nie można modyfikować Loginu" ;; 
                            4) echo "Nie można modyfikować Hasla" ;;                                                         
                            5) 
                                echo "email: "
                                read email    #wprowadzanie email do tablicy
                                array_database=( ${check_array[2]} ${check_array[3]} $login_login_base64_decode, $login_haslo_base64_decode, ${check_array[6]} "${check_array[7]}" )
                                array_database[4]="$email,"
                                sed -i  -e "s/$login_login_base64_decode Array=(.*/$login_login_base64_decode Array=( ${array_database[*]} )/" base64   #zapisanie zmian w "bazie"[base64]                                                                                                                                                                     
                                echo "Podaj opcje: " 
                            ;;
                            6) 
                                echo "tip: "
                                read -r tip    #wprowadzanie tipu do tablicy
                                check_array=($(grep "$login_login_base64_decode Array=(.*" base64)) #konwertowanie znaków wartości tablicy z pliku base64 do tablicy lokalcnej / została zmodyfikowana dlatego ta czynność jest konieczna
                                array_database=( ${check_array[2]} ${check_array[3]} $login_login_base64_decode, $login_haslo_base64_decode, ${check_array[6]} "${check_array[7]}" )                                                    
                                array_database[5]=$(echo "$tip" | sed -e "s/ /_/g")
                                sed -i  -e "s/$login_login_base64_decode Array=(.*/$login_login_base64_decode Array=( ${array_database[*]} )/" base64   #zapisanie zmian w "bazie"[base64]
                                echo "Podaj opcje: "
                            ;;
                            7)  
                                echo "Wyświetl Dane"
                                grep "^$login_login_base64_decode Array=(.*" base64 | sed "s/_/ /g" 
                            ;;
                            8) break ;;
                            *) echo "Nie ma takiej opcji modyfikacji" ;;    
                            esac
                        done
                        break
                        ;;
                3)  echo "Usun dane !Usuniecie calego konta!"
                    sed  -ie "s/Login: $login_login_base64_decode/ /" base64
                    sed  -ie "s/Login base64: $login_login_base64_code/ /" base64
                    sed  -ie "s/Haslo: $login_haslo_base64_decode/ /" base64
                    sed  -ie "s/Haslo base64: $login_haslo_base64_code/ /" base64
                    sed  -ie "s/$login_login Array=(.*/ /" base64
                    break
                    ;;
                4)  grep "^$login_login_base64_decode Array=(.*" base64
                    echo "Podaj opcje: "
                    ;;                                                    
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
                    create_array=$(echo "$rej_login_base64_decode"" Array=( 0, 0, $rej_login_base64_decode, $rej_haslo_base64_decode, 0, 0, )" >> base64 && echo >> base64 );

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

