class A

feature

	f (a: attached ANY; d: detachable ANY): attached ANY
		do
			Result := a
		end

	fa (a: attached ANY): attached ANY
		do
			Result := a
		end

	fd (d: detachable ANY): attached ANY
		do
			Result := d
		end

	fat (a: attached ANY): attached ANY
		do
			Result := a.twin
		end

	fdt (d: detachable ANY): attached ANY
		do
			Result := d.twin
		end

end