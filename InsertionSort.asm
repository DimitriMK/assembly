include 'emu8086.inc'
.model small   
.stack 100h
.data                                      
    vec db '2','1','7','5','4','6','3'
    size dw 7 
    num dw ?
.code 
main proc            
      print 'Unsorted array: '
      mov ax,@data                      
      mov ds,ax 
            mov si, offset vec  
            mov dx, size  
            mov num, dx
            sub num, 1
            showFirst:                         
            mov dl,[si]               
            mov ah,2                    
            int 21h                     
          
            mov dl,32                  
            mov ah,2                     
            int 21h              
            
            inc si                      
            
            cmp si,size              
            je sort               

            jmp showFirst
                    
            sort:               
            mov si, offset vec
            repeat:  
            mov di, si
            inc di 
            mov dx, si
            
            jmp backCompare
            
            next:
            mov si, dx
            inc si
            cmp si, num  
            je sortedPrint
            jmp repeat
           
            backCompare: 
            
            cycle:
            mov bl, [si]
            mov cl, [di]
            cmp bl, cl 
            jg swap 
            jmp notswap
            
            swap:
            mov [si], cl
            mov [di], bl
            
            notswap:
            dec di
            cmp di, 0000h
            je next
            dec si
            jmp cycle
 
            sortedPrint:
            mov dl,10                   
            mov ah,2                    
            int 21h                     
            
            mov dl,13                  
            mov ah,2                    
            int 21h
                   
            print 'Sorted array: '
            mov si, offset vec
            showEnd:                         
            mov dl,[si]               
            mov ah,2                    
            int 21h                     
          
            mov dl,32                  
            mov ah,2                     
            int 21h              
            
            inc si                      
            
            cmp si,size              
            je exit               

            jmp showEnd  
            
            exit:                                           
            mov ah,04ch                
            int 21h                     
           
main endp                               
end main 