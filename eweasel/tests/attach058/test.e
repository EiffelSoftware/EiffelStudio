class TEST

inherit
	A
		redefine
			f, fa, fd, fat, fdt
		end

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			a: detachable A
			b: attached A
		do
			a.fa (a).do_nothing
			a.fd (a).do_nothing
			a.fat (a).do_nothing
			a.fdt (a).do_nothing
			b.fa (a).do_nothing
			b.fd (a).do_nothing
			b.fat (a).do_nothing
			b.fdt (a).do_nothing
		end

feature {NONE} -- Tests

$NT	fa (a: detachable ANY): detachable ANY
$NA	fa (a: attached ANY): attached ANY
		do
			Result := a
		end

$NT	fd (d: attached ANY): detachable ANY
$NA	fd (d: detachable ANY): attached ANY
		do
			Result := d
		end

$NT	fat (a: detachable ANY): detachable ANY
$NA	fat (a: attached ANY): attached ANY
		do
			Result := a.twin
		end

$NT	fdt (d: attached ANY): detachable ANY
$NA	fdt (d: detachable ANY): attached ANY
		do
			Result := d.twin
		end

$NT	f (a: detachable ANY; b: attached ANY): detachable ANY
$NA	f (a: attached ANY; b: detachable ANY): attached ANY
		do
			Result := Precursor (a, b)
		end

end