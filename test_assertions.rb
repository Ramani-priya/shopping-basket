# Simple test runner that uses expected / actual helpers

require_relative './data_intialiser'

def expected(value)
  puts "Expected: $#{'%.2f' % value}"
  value
end

def actual(value)
  puts "Actual:   $#{'%.2f' % value}"
  value
end

def assert_equal(exp, act)
  if (exp.round(2) == act.round(2))
    puts "PASS"
    true
  else
    puts "FAIL (expected #{'%.2f' % exp} but got #{'%.2f' % act})"
    false
  end
end

results = run_examples(print: false)

results.each do |r|
  puts "\nBasket #{r[:id]} items: #{r[:items].join(', ')}"
  exp = expected(r[:expected])
  act = actual(r[:actual])
  assert_equal(exp, act)
end