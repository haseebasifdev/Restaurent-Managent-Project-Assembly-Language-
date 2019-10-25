; AddTwo.asm - adds two 32-bit integers.	
; Chapter 3 example


INCLUDE Irvine32.inc
.data

adpassword dword 1122
receivefb byte "+6.One Feedback received",0ah,0dh,0ah,0dh,0
writefb byte "what's your Suggestion: ",0
thankfb byte "Thanks For Your Feedback",0ah,0dh,0
feedback byte ".Any Suggesition",0ah,0dh,0
password byte "Enter Your Password",0ah,0dh,0
wellcome byte "****Well Come ****",0ah,0dh,0
wrong byte "Wrong Password",0ah,0dh,0
suggesion byte "Any Suggestion",0ah,0dh,0
breakfastm byte "Bread Menu",0ah,0dh,0ah,0dh,0
lunchm byte "Rice Menu",0ah,0dh,0ah,0dh,0
dinnerm byte "Meat Menu",0ah,0dh,0ah,0dh,0
Echoise byte "Enter Your Choise: ",0

strstore byte 30 dup (?)
editing byte "+9.Edit Menu Price(For Admin Only)",0ah,0dh,0
invalid byte "Invalid Entry",0ah,0dh,0
totalbillstr byte  ".Place order And Generate Total Bill ",0ah,0dh,0
nodish byte "No Dish Selected yet",0ah,0dh,0
totbill byte "Your Total Bill: ",0
totalbill dword 0  
bytecounter dword ?
dishname byte "Dish Name: ",0
flag dword 0
loom dword 5
loopb dword 3
loopl dword 3
loopdi dword 3
order dword 0
M1 byte  "                 ****Welcome to Our Restaurants****",0
M2 byte "Enter your Choise press '0' or 'ENTER Key' to exit",0
main1 byte ".Bread Menu",0
main2 byte ".Rice Menu",0
main3 byte ".Meat Menu",0
billstring byte  "Enter Quantity: ",0
selectmenu byte  "Choise Menu For Edit price: ",0
price byte "Enter Price: ",0
;breakfast main
main11 byte ".Tanduri Roti            ",0
main12 byte ".Nan                     ",0
main13 byte ".Parata                  ",0
main14 byte 30 dup (0)
main15 byte 30 dup (0)
;lunch menu
main21 byte ".Kachchi Birani(Kabab+Egg)              ",0
main22 byte ".Chicken Birani(Kabab+Egg)              ",0
main23 byte ".Plain Polaw                            ",0
main24 byte 30 dup (0)
main25 byte 30 dup (0)
;dinner
main31 byte ".Goats Brain             ",0
main32 byte ".Chicken Bhuna Khichuri  ",0
main33 byte ".Mutton Bhuna Khichuri   ",0
main34 byte 30 dup (0)
main35 byte 30 dup (0)

nextl byte " ",0ah,0dh,0
;main string
mainstr dword main1,main2,main3,feedback,totalbillstr

;breakfaststring
mainstr1 dword main11,main12,main13
rupee1 dword 10,10,10

;lunch string
mainstr2 dword main21,main22,main23
rupee2 dword 60,60,60

;dinner string
mainstr3 dword main31,main32,main33
rupee3 dword 90,90,90

count dword 0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.code

main PROC

Read:
;call main instructions
mov esi ,0
lea edx,M1
call writestring
call nl
start:
call nl
call nl
lea edx,M2
call writestring
mov count,0
call nl
call nl
mov ecx,loom
mov esi,0

;main menu
mainmenu:
add count,1
mov eax,count
call writeint
mov edx,[mainstr+esi]
call writestring
call nl
add esi,4
loop mainmenu
call nl 
call nl

.if flag==1
lea edx,receivefb
call writestring
.endif

lea edx,Echoise
call writestring
call readint
cmp eax,1
je b1

cmp eax,2
je l1

cmp eax,3
je d1

cmp eax,4
je suggest

cmp eax,5
je tbill


cmp eax,0
je proexit

cmp eax,6
je feedbackl
cmp eax,6
jge error


;Breakfast

b1:
call pbreakfast		;call to print breakfast menu
lea edx,editing
call writestring

lea edx,Echoise
call writestring

call readint		;take input 

cmp eax,9
je editbp

;cmp eax,4
;je addbreakfast

cmp eax,0
je proexit

cmp eax,4
jge error

jmp calbillb



;lunch
l1:

call plunch
lea edx,editing
call writestring

lea edx,Echoise
call writestring

call readint

cmp eax,0
je proexit

cmp eax,9
je editlp

cmp eax,4
jge error

jmp calbilll

;dinner
d1:
call pdinner

lea edx,editing
call writestring

lea edx,Echoise
call writestring

call readint

cmp eax,0
je proexit

cmp eax,9
je editdp

cmp eax,4
jge error

jmp calbilld


;Calculate bill breaak fast
calbillb:

 call nl
 call nl
;mov order,eax		;store input
sub eax,1			;subtract For to move correct string
mov ecx,eax			;Store in ECX to move correct string
mov esi,0

cmp ecx,0			;in case string is 1st
je next1

billb:				;start loop
add esi,4
loop billb			;loop
next1:

lea edx,billstring
call writestring
call readint

mov order,eax
mov eax,[rupee1+esi];store Dish Price
mul order

call nl 
call nl
add totalbill,eax	;store in For the sake total Price for 1 Customer
lea edx,totbill
call writestring

call writeint		;Print Price
call nl				;Next Line Funtion
call nl
call nl

jmp start


;calculate bill lunch

calbilll:

 call nl
 call nl
;mov order,eax
sub eax,1
mov ecx,eax
mov esi,0
cmp ecx,0
je next2
billl:
add esi,4
loop billl
next2:
lea edx,billstring
call writestring
call readint
mov order,eax
mov eax,[rupee2+esi]
mul order

call nl 
call nl
lea edx,totbill
call writestring
add totalbill,eax
call writeint
call nl
call nl
call nl
jmp start

;calculate bill dinner

calbilld:

 call nl
 call nl
mov order,eax
sub eax,1
mov ecx,eax
mov esi,0
cmp ecx,0
je next3
billd:
add esi,4
loop billd
next3:
lea edx,billstring
call writestring
call readint
mov order,eax
mov eax,[rupee3+esi]
mul order
call nl 
call nl
lea edx,totbill
call writestring
add totalbill,eax
call writeint
call nl
call nl
call nl
jmp start


;Total Bill Calculate
tbill:

 call nl
 call nl
mov eax,totalbill

;start if
.if totalbill==0
call nl 
call nl
lea edx,nodish
call writestring
jmp start
.endif
;end if

call nl 
call nl
lea edx,totbill
call writestring
call writeint
mov totalbill,0
call nl
call nl
jmp start


;Edit break fast menu price
editbp:

 call nl
 call nl
lea edx,password
call writestring
call readint

.if eax==adpassword
call nl
call nl
lea edx,wellcome
call writestring
.else
lea edx,wrong
call writestring
jmp start
.endif

 call nl
 call nl
call pbreakfast
lea edx,selectmenu
call writestring
call readint

mov order,eax
sub eax,1
mov ecx,eax
mov esi,0
cmp ecx,0
je nexte1
editp1:
add esi,4
loop editp1
nexte1:
lea edx,price
call writestring
call readint
mov [rupee1+esi],eax
jmp start

;Edit lunch menu price
editlp:

 call nl
 call nl
lea edx,password
call writestring
call readint

.if eax==adpassword
call nl
call nl
lea edx,wellcome
call writestring
.else
lea edx,wrong
call writestring
jmp start
.endif

 call nl
 call nl
call plunch
lea edx,selectmenu
call writestring
call readint

sub eax,1
mov ecx,eax
mov esi,0
cmp ecx,0
je nexte2
editl1:
add esi,4
loop editl1
nexte2:
lea edx,price
call writestring
call readint
mov [rupee2+esi],eax
jmp start


;Edit dinner menu price
editdp:

 call nl
 call nl
lea edx,password
call writestring
call readint

.if eax==adpassword
call nl
call nl
lea edx,wellcome
call writestring
.else
lea edx,wrong
call writestring
jmp start
.endif

 call nl
 call nl
call pdinner
lea edx,selectmenu
call writestring
call readint
sub eax,1
mov ecx,eax
mov esi,0
cmp ecx,0
je nexte3
editd1:
add esi,4
loop editd1
nexte3:
lea edx,price
call writestring
call readint
mov [rupee3+esi],eax
jmp start


;print error message
error:
 call nl
 call nl
lea edx,invalid
call writestring
jmp start

suggest:
call nl 
call nl
mov flag,1
lea edx,writefb
call writestring
mov edx,offset strstore
mov ecx,sizeof strstore
call readstring

call nl
call nl

lea edx,thankfb
call writestring
 
call nl 
call nl
jmp start


feedbackl:
lea edx,strstore
call writestring
mov flag,0
jmp start

;;;;;add New menu in Break Fast
addbreakfast:
call pbreakfast
lea edx,selectmenu
call writestring
call readint
mov order,eax
sub eax,1
mov ecx,eax
mov esi,0
cmp ecx,0
je nextadd1
addb1:
add esi,4
loop addb1
nextadd1:
lea edx,dishname
call writestring
mov edx,offset strstore
mov ecx,sizeof strstore
call readstring
INVOKE Str_copy,
ADDR strstore,
ADDR [mainstr1+esi]
;mov bytecounter,eax
mov edx,[mainstr1+esi]
call writestring
lea edx,price
call writestring
call readint
mov [rupee1+esi],eax
jmp start


proexit:
	exit
main endp




;////////////////////////////////////////////////////////////////////////////////////////
;funtion Print Breakfast menu
pbreakfast proc
 call nl
 call nl
 call nl
 call nl
lea edx,breakfastm
call writestring
mov ecx,loopb
mov esi,0
mov count,0
breakfast:
add count,1
mov eax,count
call writeint
mov edx,[mainstr1+esi]
call writestring
mov eax,[rupee1+esi]
call writeint
call nl
add esi,4
loop breakfast
ret
pbreakfast endp


;funtion  print lunch menu
plunch proc
 call nl
 call nl
 call nl
 call nl
lea edx,lunchm
call writestring
mov ecx,loopl
mov esi,0
mov count,0
lunch:
add count,1
mov eax,count
call writeint
mov edx,[mainstr2+esi]
call writestring
mov eax,[rupee2+esi]
call writeint
call nl
add esi,4
loop lunch
ret
plunch endp


;funtion print dinner menu
pdinner proc
 call nl
 call nl
 call nl
 call nl
lea edx,dinnerm
call writestring
mov ecx,loopdi
mov esi,0
mov count,0
dinner:
add count,1
mov eax,count
call writeint
mov edx,[mainstr3+esi]
call writestring
mov eax,[rupee3+esi]
call writeint
call nl
add esi,4
loop dinner
ret
pdinner endp
 

;funtion next line
nl proc
lea edx,nextl
call writestring
ret
nl endp

end main