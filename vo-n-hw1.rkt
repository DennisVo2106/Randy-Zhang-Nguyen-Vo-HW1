;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname vo-n-hw1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;Nguyen Vo
;;HW1 

;;1 AND 2
;;construct a date file, storing year, month, and day
(define-struct date(year month day))
;;year: year of date
;;month: month of date
;;day: day of date
(define D1(make-date 2016 12 21))
(define D2(make-date 2021 3 12))
(define D3(make-date 2021 9 17))
;;contstruct a film file, storing tile, rating, running-time,opening-date, and nominations 
(define-struct film(tile genre rating runningtime openingdate nominations))
;;interp: represents a film constrictor where
;; tile: film's tile
;; genre: film's genre
;; rating: film's rating
;; running-time : the runnig-time of the film
;; openig-date : the date the film opened at the theater
;; nominationsL : the number of oscar nominations the film recieved
(define film1 (make-film 'passenger 'sci-fi 'PG-13 116 D1 4))
(define film2 (make-film 'dad-im-sorry 'drama 'PG-13 128 D2 1))
(define film3 ( make-film 'squid-game 'survial 'NR 63 D3 35))


;;3
;;film->boolean
;;consume a film to produce a boolean if the film is a drama and has running time more than 150
;or was nomianted and has rating of NC-17 AND NR
(define (high-brow? F)
  (or
   (and
    (equal?(film-genre F)'drama)
    (>(film-runningtime F) 150)
    )
   (and
    (>=(film-nominations F)1)
    (or
     (equal? (film-rating F) 'NC-17)
     (equal? (film-rating F) 'NR)
     )
    )
   )
  )
(check-expect(high-brow? film1)false)
(check-expect(high-brow? film2)false)
(check-expect(high-brow? film3)true)

;;4
;;num num -> num
;;consume number of nominatinos from 2 films and produce the total nominations of 2 films
(define (total-nominations F1 F2)
  (+(film-nominations F1)
    (film-nominations F2)
    )
  )
(check-expect(total-nominations film1 film2)5)
(check-expect(total-nominations film2 film3)36)
(check-expect (total-nominations film1 film3)39)

;;5
;;film num-> film
;;consume a film and a number to produce a film with new number as nem nominations
(define (update-nominations film number-of-oscars)
  (make-film (film-tile film)(film-genre film)(film-rating film)(film-runningtime film)(film-openingdate film)number-of-oscars))
(check-expect(update-nominations film1 7)(make-film 'passenger 'sci-fi 'PG-13 116 D1 7))
(check-expect(update-nominations film2 8)(make-film 'dad-im-sorry 'drama 'PG-13 128 D2 8))
(check-expect(update-nominations film3 9)(make-film 'squid-game 'survial 'NR 63 D3 9))

;;6
;;helper fuction
;;creat a temporary date, storing year month date
(define (date-temp year month day)
  (make-date year month day))
(check-expect(date-temp 2012 06 21)(make-date 2012 6 21))
(check-expect(date-temp 2016 12 21)(make-date 2016 12 21))
(check-expect(date-temp 2021 9 17)(make-date 2021 9 17))
;;film date -> boolean
;;consume a film and a date-temp to produce a boolean
(define (opened-after film date-temp)
  (equal?(film-openingdate film)date-temp))
(check-expect(opened-after film1 (date-temp 2012 06 21))false)
(check-expect(opened-after film2 (date-temp 2016 12 21))false)
(check-expect(opened-after film3 (date-temp 2021 9 17))true)