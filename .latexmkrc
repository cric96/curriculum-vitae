# Support for multibib
# Detect all .aux files and run bibtex on those that contain \bibdata
add_cus_dep( 'aux', 'bbl', 0, 'bibtex' );
sub bibtex {
   if (open(AUX, $_[0].'.aux')) {
      while (<AUX>) {
         if (/^\\bibdata/) {
            close(AUX);
            return system("bibtex \"$_[0]\"");
         }
      }
      close(AUX);
   }
   return 0;
}

# Ensure .bbl files are tracked as dependencies
push @generated_exts, 'bbl', 'blg';

$pdflatex = 'pdflatex -interaction=nonstopmode -halt-on-error %O %S';
