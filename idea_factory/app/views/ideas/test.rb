hash = { "a" => 100, "b" => 200, "c" => 300, "d" => 300 }
puts hash.key(200)   #=> "b"
puts hash.key(300)   #=> "c"
puts hash.key(999)   #=> nil