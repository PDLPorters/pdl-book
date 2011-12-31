use PDL;
## creating the mem device buffer ##

# the mem device
# Allocate the buffer for plain rgb
my $buffer = zeroes(byte, 3, $width, $height);

# Create the PLplot object
my $pl = PDL::Graphics::PLplot->new(
                 DEV => 'mem',
                 MEM => $buffer
          );


## For the memcairo device which handles tranparencies ##

# Allocate the buffer
my $buffer = zeroes(byte, 4, $width, $height);

# Create the PLplot object
my $pl = PDL::Graphics::PLplot->new(
                 DEV => 'memcairo',
                 MEM => $buffer
          );
