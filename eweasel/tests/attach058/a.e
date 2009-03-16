class A

feature

	f (a: attached ANY; b: detachable ANY): attached ANY
		do
			Result := a
			Result := b
			Result := a.twin
			Result := b.twin
		end

end